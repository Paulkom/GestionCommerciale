"use strict";
var GESTIONLIVRAISON = function() {
   
    /**
     * Vérifie s'il s'agit bien d'un élément HTML
     * @param element
     * @returns {boolean}
     */

    var unicite=[];
    var fieldList={};
    var selectedoptions = [];
    var fieldList;
    const isElement = (element) => {
        return element instanceof Element || element instanceof HTMLDocument;
    }
    const ajaxBeforeSend = () => {
        let loadingEl = document.createElement("div");
        document.body.prepend(loadingEl);
        loadingEl.classList.add("page-loader");
        loadingEl.classList.add("flex-column");
        loadingEl.classList.add("bg-dark");
        loadingEl.classList.add("bg-opacity-25");
        loadingEl.innerHTML = `
                                <span class="spinner-border text-primary" role="status"></span>
                                <span class="fs-6 fw-semibold mt-5" style="color:#ffffff">Chargement...</span>
                            `;
        document.body.classList.add('page-loading');
        document.body.setAttribute('data-kt-app-page-loading', "on")
    }
    
    const ajaxComplete = () => {
        document.body.classList.remove('page-loading');
        document.body.removeAttribute('data-kt-app-page-loading');
    }


    const addFormDeleteLink = (form) => {
        if (isElement(form)) {
            const removeFormButton = form.querySelector('.collection-action');
            if (removeFormButton    ) {
                removeFormButton.addEventListener('click', (e) => {
                    $.ajax({
                        type: "POST",
                        url: removeFormButton.dataset.url,
                        data: {token: removeFormButton.dataset.token},
                        dataType: "json",
                        beforeSend: ajaxBeforeSend,
                        success: function(data){
                            /*ajaxDeleteResult(form, data);*/
                        },
                        complete: ajaxComplete
                    });
                    delete form_children[form.getAttribute('id')];
                    form.remove();
                });
            }
        }
    }
    

    /**
     * Permet d'ajouter un ou plusieurs formulairs imbriqués
     * à un formulaire parent après un clic sur le bouton d'ajout
     * @param e
     */
    const addFormToCollection = (e) => {
        if(container != null)
        {
            /**
             * Récupérer l'élément conteneur de formulaires imbriqués
             */
            var collectionHolder;
            
            if(e.currentTarget ==undefined) {
                 collectionHolder = e[0];
            }else{
                collectionHolder = container.querySelector('.' + e.currentTarget.dataset.collectionHolderClass);
            }
                
            
            // const collectionHolder = container.querySelector('.' + e.currentTarget.dataset.collectionHolderClass);
            /**
             * Récupérer la forme brute du formulaire à imbriqué
             */
            
            const prototype = collectionHolder.dataset.prototype;
            // console.log(prototype,'prototype');
            const div = document.createElement('div');
            const protokey = collectionHolder.dataset.collectionKey;
            var regex = new RegExp(protokey, "g");
            div.setAttribute('data-index', collectionHolder.dataset.index);
            const prefix = collectionHolder.dataset.collectionPrefix.replace(regex, collectionHolder.dataset.index);
            div.setAttribute('id', prefix);
            div.classList.add("ligne");
            div.classList.add("form-child");
            div.innerHTML = prototype.replace(regex, collectionHolder.dataset.index);
            

            let commande = $(container).find('select[name*="[commandeCli]"] option:selected').val();
            if(commande){
                $.ajax({
                    url: app_loader_mag_comd,
                    dataType: "Json",
                    data: {
                        id: isNaN(commande) ? 0 : commande,
                    },
                    type: "GET",
                    beforeSend: function () {
                        ajaxBeforeSend();
                    },
                    success: function (res) {
                        $(div).find('select[name*="[magasin]"]').html(res);
                        console.log('resultat',res);
                        console.log('magasin',$(div).find('select[name*="[magasin]"]'));
                    },
                    complete: function () {
                        ajaxComplete();
                    },
                });
            }
            
            /**
             * Ajouter la forme html du formulaire imbriqué au conteneur
             */
            collectionHolder.appendChild(div);
            $(collectionHolder).find('[data-control="select2"]').select2();
            // console.log(div,'div');
            addFormDeleteLink(div);
            form_children[prefix] = [];
            //initializeContainer(collectionHolder);
            livContainer(collectionHolder);
            if($(collectionHolder).hasClass("magasin")){
                $.each($(collectionHolder).find('select[name*="[magasin]"]'), function (i, elt) {
                    let seletcom = $(container).find('select[name*="[commandeCli]"]');
                    var commandeCli = $(seletcom).find('option:selected').val();
                    var magSelect = $(this);
                    magSelect.change(function () {
                        $(container).find('button[type="submit"]').attr('disabled',false);
                        selectedoptions[magSelect.attr('name')] = $(this).val();
                        desactiverSelect();
                        if(commandeCli) {
                            // console.log($(this).val(),'mag');
                            // console.log(commandeCli,'commandeCli');
                            $.ajax({
                                url: app_loader_prod_comd,
                                dataType: "Json",
                                data: {
                                    id: isNaN(commandeCli) ? 0 : commandeCli,
                                    magid: isNaN($(this).val()) ? 0 : $(this).val(),
                                },
                                type: "GET",
                                beforeSend: function () {
                                    ajaxBeforeSend();
                                },
                                success: function (resulta) {
                                    $(magSelect.parent().parent().parent().parent().parent()).find('.produit').html('');
                                    // console.log(resulta);
                                    for (let i = 0; i < resulta.length; i++) {
                                        // console.log(magSelect.parents('.rounded'),'collection');
                                        // console.log($(magSelect.parent().parent().parent().parent().parent()).find('.produit'),'parent');
                                        var form = addFormToCollection($(magSelect.parent().parent().parent().parent().parent()).find('.produit'));
                                        // console.log($(form).find('select[name*="[produitComClit]"]'),'form');
                                        var option ='<option value="'+resulta[i]['id']+'">'+ resulta[i]['id'] +'</option>';
                                        $(form).find('select[name*="[produitComClit]"]').html(resulta[i]);
                                        var blocproduit     = $(form).find('select[name*="[produitComClit]"]').parent().parent();
                                        var option          = $(form).find('select[name*="[produitComClit]"]').find('option:selected');
                                        var qteRALiv        = option.data('restaliv');
                                        var qteLiv          = option.data('qtite');
                                        var prix            = option.data('prix');
                                        var montantcom      = option.data('montant');

                                        //calcul pièce et carton
                                        let ppc = parseFloat(option.attr('piece-par-carton'));
                                        let m2pc = parseFloat(option.attr('m2-par-carton'));
                                        let modeCarreau = option.attr('est-mode-carreau');
                                        
                                        if(modeCarreau == 1){
                                            let result = calculPieceCarton(qteLiv, ppc, m2pc);
                                            blocproduit.find('input[name*="carton"]').val(result['carton']);
                                            blocproduit.find('input[name*="piece"]').val(result['piece']);
                                            blocproduit.find('input[name*="piece"]').closest('.fv-row').removeClass('d-none');
                                            blocproduit.find('input[name*="carton"]').closest('.fv-row').removeClass('d-none');
                                        }
                                        //fin

                                        if(typeof qteRALiv ==="undefined" || qteRALiv=='' || qteRALiv==null){
                                            qteRALiv=0;
                                        }else{
                                            if (parseFloat(qteRALiv) > 0) {
                                                qteLiv=qteRALiv;
                                            }
                                        } 
                                        blocproduit.find('input[name*="[qteRALiv]"]').val(0);
                                        blocproduit.find('input[name*="[qteALiv]"]').val(qteLiv);
                                        blocproduit.find('input[name*="[qteLiv]"]').val(qteLiv);
                                        blocproduit.find('input[name*="[montantCond]"]').val(montantcom);
                                        blocproduit.find('input[name*="[prix]"]').val(prix)                                 
                                    }
                                    qteraliv();
                                },
                                complete: function () {
                                    ajaxComplete();
                                },
                            });
                            
                        }
                        
                    })
                });
            }

            /** Incrémentation de l'index après insertion du formulaire imbriqué **/
            collectionHolder.dataset.index++;
            return div;
        }           
    }
    var desactiverSelect=()=>{
        var mesoption=[];
        // console.log(mesoption,selectedoptions,'mesoption');
        for(var key in selectedoptions) {
            mesoption.push(selectedoptions[key]);
        }

        $.each($(container).find('select.livraison'), function (i, elt) {
            // console.log(elt,'elt',i);
            $.each($(elt).find('option:not(:selected)'), function(i, item) {
                //console.log(item.value,selectvalu);
                if ($.inArray($(this).val() , mesoption) != -1) {
                    $(item).prop("disabled", true);
                } else {
                    $(item).prop("disabled", false);
                }
                //
                // console.log($(item).attr("data-qtestockcond"),"qtestockcond");

                if(parseFloat($(item).attr("data-qtestockcond")) > 0 ) {
                   //$(item).prop("disabled", false);
                }else{
                    //$(item).prop("disabled", true); 
                }
            });
        })
    }
    var qteraliv=()=>{
        var totalqteraliv = 0;
        let qteralivs = $(".qteraliv");
        for ( let i = 0; i < qteralivs.length; i++) {
            if($(qteralivs[i]).val() !=''){
                totalqteraliv += parseFloat($(qteralivs[i]).val());
            }
        }
        $(container).find('input[name*="totalResteAliv"]').val(totalqteraliv);
    }
    var eventChange=()=>{
        desactiverSelect();
        $.each($($(container).find('select')), function (i, elt) {
            let select = $(elt);
            name = select.attr('name');
            let blocproduit = select.parent().parent();
            var selected = $(this).find('option:selected').val();
            // console.log('select',select);
            if(name.includes('[produitComClit]')){
                select.parent().next()
                select.change(function () {
                    var option = $(this).find('option:selected');
                    var qteRALiv = option.data('restaliv');
                    var qteLiv  = option.data('qtite');
                    var prix     = option.data('prix');
                    var montantcom     = option.data('montant');
                    if(typeof qteRALiv ==="undefined" || qteRALiv=='' || qteRALiv==null){
                        qteRALiv=0;
                    } 
                    blocproduit.find('input[name*="[qteRALiv]"]').val(qteRALiv);
                    blocproduit.find('input[name*="[qteALiv]"]').val(qteLiv);
                    blocproduit.find('input[name*="[qteLiv]"]').val(qteLiv);
                    blocproduit.find('input[name*="[montantCond]"]').val(montantcom);
                    blocproduit.find('input[name*="[prix]"]').val(prix)
                   /* blocproduit.find('input[name*="qteLiv"]').keyup(function () {
                        var montant = 0;
                        var qtite= parseFloat(blocproduit.find('input[name*="qteLiv"]').val());
                        if(parseFloat(qtite) > 0){
                            montant= prix*qtite;
                            qteRALiv = parseFloat(qteLiv)-qtite;
                            blocproduit.find('input[name*="montantCond"]').val(montant);
                            blocproduit.find('input[name*="qteRALiv"]').val(qteRALiv);
                            var totalsomme = 0;
                            let montantParProduit = $(".montant");
                            for(let i = 0; i < montantParProduit.length; i++) {
                                if($(montantParProduit[i]).val() !=''){
                                    totalsomme += parseFloat($(montantParProduit[i]).val());
                                }
                            }
                            $(container).find('input[name*="montantLiv"]').val(totalsomme);
                        }
                    });*/

                    var totalsomme = 0;
                    let montantParProduit = $(".montant");
                    for ( let i = 0; i < montantParProduit.length; i++) {
                        if($(montantParProduit[i]).val() !=''){
                            totalsomme += parseFloat($(montantParProduit[i]).val());
                        }
                    }
                    $(container).find('input[name*="montantLiv"]').val(totalsomme)
                })
            }
            if(name.includes('[magasin]')){
                select.change(function () {
                    selectedoptions[$(this).attr('name')] = $(this).val();
                })
            }
           
           /* if(name.includes('[]')){
                console.log(select);
                selected = $(this).find('option:selected').val();
                select.change(function () {
                    $(collectionHolder).html('');
                });
            }*/

        });

        $.each($($(container).find("input:not([readonly=readonly]")),function (k, elt) {
            // console.log($(elt));
           
             var name = $(this).attr("name");
             
            if (typeof name != "undefined") {

                var input = $(elt);
                let blocproduit = input.parent().parent();
                // let seletcom = $(blocproduit).find('select[name*="[produitComClit]"]');
               // console.log(seletcom,'seletcom');
               
                // var option = seletcom.find('option:selected');
                // console.log(option.val(),'option');
                // //var prix = option.attr("data-prix");
                 input.keyup(function () {
                    var montant = 0;
                    var prix = parseFloat(blocproduit.find('input[name*="[prix]"]').val());
                    var qteRALiv = parseFloat(blocproduit.find('input[name*="[qteRALiv]"]').val());
                    var qtite = parseFloat(blocproduit.find('input[name*="[qteALiv]"]').val());
                    var montantcom  =parseFloat(blocproduit.find('input[name*="[montant]"]').val());
                    var qteLiv = parseFloat(blocproduit.find('input[name*="[qteLiv]"]').val());
                    // console.log('prix',prix,qtite,qteLiv,qteRALiv);
                   
                    //qtite = parseFloat(blocproduit.find('input[name*="[qteLiv]"]').val());
                    if(qteLiv >= 0 && qteLiv <= qtite){
                        // console.log(qteLiv,prix);
                        montant = prix*qteLiv;
                        qteRALiv = qtite-qteLiv;
                        blocproduit.find('input[name*="[montantCond]"]').val(montant);
                        blocproduit.find('input[name*="[qteRALiv]"]').val(qteRALiv);
                        $(container).find('button[type="submit"]').attr('disabled',false); 

                        //Recalcul de carton et piece
                        let ppc = parseFloat(blocproduit.find('select[name*="[produitComClit]"]').find('option:selected').attr('piece-par-carton'));
                        let m2pc = parseFloat(blocproduit.find('select[name*="[produitComClit]"]').find('option:selected').attr('m2-par-carton'));
                        let modeCarreau = blocproduit.find('select[name*="[produitComClit]"]').find('option:selected').attr('est-mode-carreau');
                        
                        if(modeCarreau == 1){
                            let result = calculPieceCarton(qteLiv, ppc, m2pc);
                            blocproduit.find('input[name*="carton"]').val(result['carton']);
                            blocproduit.find('input[name*="piece"]').val(result['piece']);
                            blocproduit.find('input[name*="piece"]').closest('.fv-row').removeClass('d-none');
                            blocproduit.find('input[name*="carton"]').closest('.fv-row').removeClass('d-none');
                        }
                        //fin

                       
                    }else{
                        blocproduit.find('input[name*="[qteRALiv]"]').val(''); 
                        blocproduit.find('input[name*="[qteLiv]"]').val(''); 
                        blocproduit.find('input[name*="[montantCond]"]').val(0);
                        blocproduit.find('input[name*="carton"]').val(0);
                        blocproduit.find('input[name*="piece"]').val(0);
                        $(container).find('button[type="submit"]').attr('disabled',true); 

                    }
                    var totalsomme = 0;
                    let montantParProduit = $(".montant");
                    for(let i = 0; i < montantParProduit.length; i++) {
                        if($(montantParProduit[i]).val() !=''){
                            totalsomme += parseFloat($(montantParProduit[i]).val());
                        }
                    }
                    $(container).find('input[name*="[montantLiv]"]').val(totalsomme);
                    qteraliv();
                })
            }
         });
    }

    var loadnewForm =()=>{
        if($(container).find('form').attr('action') === undefined ){
            $(newform).find('[data-control="select2"]').select2();
            $(container).html(newform);
            $(container).find('[data-control="select2"]').select2();  
        }
    }

    const livContainer = (collectionHolder = null) => {
        let parent = container;
        if(collectionHolder != null)
            parent = collectionHolder;


        $(parent).find('[data-control="select2"]').select2();     
        parent.querySelectorAll('.add_livraison_item_link').forEach(btn => {
            btn.addEventListener("click", addFormToCollection);
            const holders = container.querySelectorAll('.' + btn.dataset.collectionHolderClass);
           
            holders.forEach(h => {
                const divs = h.querySelectorAll('div.form-child');
                divs.forEach(div => {
                    if(collectionHolder == null)
                        form_children[div.getAttribute('id')] = [];
                    addFormDeleteLink(div);
                });
            });
        });
        const btnS = parent.querySelectorAll('button[type="submit"]');
        if(btnS != null)
        {
            btnS.forEach(btn => {
                const form = btn.closest('form');
                if (form != null && form != undefined) {
                    var validation = valitation(form,fieldList)
                    btn.addEventListener("click", function(e) {
                        e.preventDefault();
                        var erreur = false;
                        for (const key in unicite) {
                            if (unicite[key]) {
                                erreur = true;
                                break;
                            }
                        }
                        if($(this).hasClass("imprimer") == true){
                            $("#livraison_truc").val("OUI");
                        }else{
                            $("#livraison_truc").val("NON");  
                        }
                        save(form,validation,btn,erreur);
                    });
                }
            });
        }

        let seletcom = $(container).find('select[name*="[commandeCli]"]');
        //var selected = $(seletcom).find('option:selected').val();
        if(seletcom){
            seletcom.change(function () {
                var selected = $(this).find('option:selected').val();
                    $.each($($(container).find('.add_livraison_item_link')), function (i, button) {
                        if(selected){
                            $(button).attr('disabled',false);
                        }else{
                            $(button).attr('disabled',true);
                        }
                    });
                $(container).find('.collection-form').html('');
                $(container).find('button[type="submit"]').attr('disabled',true); 
                selectedoptions=[];
                qteraliv();
            });
        }

        const addbtn = document.querySelector('[data-kt-entity-table-filter="new_form"]');
        addbtn.addEventListener('click', function (e) {
            // console.log('click',addbtn)
            loadnewForm();
            livContainer()
        });
        eventChange();
    }

    var handlelistes = () => {
        // Select all delete buttons
        const buttons = document.querySelectorAll('[data-kt-entity-table-filter="list"]');
        const bloc = document.querySelector('[data-call-form="ajax"]');
        buttons.forEach(d => {
            d.addEventListener('click', function (e) {
                e.preventDefault();
                console.log(console.log(e.target));
                $.ajax({
                    type: "GET",
                    url: e.target.dataset.url,
                    dataType: "json",
                    beforeSend: function () {
                        const loadingEl = document.createElement("div");
                        document.body.prepend(loadingEl);
                        loadingEl.classList.add("page-loader");
                        loadingEl.classList.add("flex-column");
                        loadingEl.classList.add("bg-dark");
                        loadingEl.classList.add("bg-opacity-25");
                        loadingEl.innerHTML = `
                                            <span class="spinner-border text-primary" role="status"></span>
                                            <span class="fs-6 fw-semibold mt-5" style="color:#ffffff">Chargement...</span>
                                        `;
                        document.body.classList.add('page-loading');
                        document.body.setAttribute('data-kt-app-page-loading', "on")
                    },
                    success: function(data){
                        //livContainer();
                        $(bloc).html(data.html);
                        const form = bloc.querySelector('form');
                        if(form){
                            form.querySelectorAll('select').forEach(s => {
                                $(s).select2();
                            });
                            //gestionVente.init();
                        }else{
                            if($(bloc).find('.kt_entity_table').length > 0)
                            {
                                tableau = $(bloc).find('.kt_entity_table')[0];
                                loadDataTable();
                            }
                        } 
                    },
                    complete: function () {
                        document.body.classList.remove('page-loading');
                        document.body.removeAttribute('data-kt-app-page-loading');
                    }
                });
            })
        });
    }

    return {
        init: function() {
            loadnewForm();
            livContainer();
            handlelistes();
            //eventChange();
            $(container).find('button[type="submit"]').attr('disabled',true);
        }
    }
}();
KTUtil.onDOMContentLoaded((function() {
    GESTIONLIVRAISON.init();
}));
var KTCaisse = function() {
    /**
     * Vérifie s'il s'agit bien d'un élément HTML
     * @param element
     * @returns {boolean}
     */
    var selectedoptions = [];
    const isElement = (element) => {
        return element instanceof Element || element instanceof HTMLDocument;
    }
    
    const ajaxDeleteResult = (form, data) => {
        console.log(form);
        form.remove();
        if(data != null)
        {
            console.log(data);
        }
    }
    const addFormDeleteLink = (form) => {
        if (isElement(form)) {
            console.log(form);
            const removeFormButton = form.querySelectorAll('button.remove');
            let succes = false;
            removeFormButton.forEach(btnremove => {
                btnremove.addEventListener('click', (e) => {
                var namer =$(form).find('select[name*="[personnel]"]').attr('name');
                delete selectedoptions[namer];
                console.log(namer,selectedoptions,'namer');
                form.remove();
                desactiverSelect();
            });
        })
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
           // var container = document.querySelector('[data-call-form="ajax"]');
           
            /**
             * Récupérer l'élément conteneur de formulaires imbriqués
             */
            const collectionHolder = container.querySelector('.' + e.currentTarget.dataset.collectionHolderClass);
            /**
             * Récupérer la forme brute du formulaire à imbriqué
             */
            const prototype = collectionHolder.dataset.prototype;
            const div = document.createElement('div');
            div.classList.add('col-sm-4');
            div.innerHTML = prototype.replace(
                /__name__/g,
                collectionHolder.dataset.index
            );
            /**
             * Ajouter la forme html du formulaire imbriqué au conteneur
             */
            collectionHolder.appendChild(div);
            addFormDeleteLink(div);
            $(collectionHolder).find('[data-control="select2"]').select2();
            // Inputmask("decimal", {
            //     "rightAlignNumerics": false
            // }).mask(".decimal");

           /* $(collectionHolder).find(".decimal").inputmask("decimal", {
                rightAlign: true,
                allowMinus: false,
                allowPlus: false,
            });*/
            /** Incrémentation de l'index après insertion du formulaire imbriqué **/
            collectionHolder.dataset.index++;
            //collectionHolder.find('select[name*="[monnaie]"]').trigger('change');
            //collectionHolder.find('select[name*="[monnaie]"]').select2('readonly', true);

            $.each($($(collectionHolder).find('select')), function (i, elt) {
                let select = $(elt);
                name = select.attr('name');
                let blocmonnaie = select.parent().parent();
                var selected = $(this).find('option:selected').val();
                console.log('select',select);
                // if(name.includes('[monnaie]')){
                //     select.parent().next()
                //     select.change(function () {
                //         var option = $(this).find('option:selected');
                //         var textselected = $(option).text();
                //         var tab = textselected.split(" ");
                //         var prixbrute = tab[tab.length -1];
                //         var prixbrute1 = prixbrute.replace('[','');
                //         var prix = prixbrute1.replace(']','');

                //         // blocmonnaie.find('input[name*="[nbr]"]').val('');
                //         // blocmonnaie.find('input[name*="[montant]"]').val('');
                //         if(blocmonnaie.find('input[name*="[nbr]"]').val() != ''){
                //             blocmonnaie.find('input[name*="[montant]"]').val((parseFloat(blocmonnaie.find('input[name*="[nbr]"]').val())*parseFloat(prix)));
                //             let montantParmonnaie = $(".montant");
                //             var totalsomme = 0;
                //             for(let i = 0; i < montantParmonnaie.length; i++) {
                //                 if($(montantParmonnaie[i]).val() !=''){
                //                     totalsomme += parseFloat($(montantParmonnaie[i]).val());
                //                 }
                //             }
                //             if(etatcaisse==="ouverture"){

                //                 $(container).find('input[name*="[fondRoulement]"]').val(totalsomme);
                //                 $(container).find('input[name*="caisse[chiffreAffaire]"]').val(totalsomme- parseFloat($(container).find('input[name*="[fondRoulement]"]').val()));
                //             }else{
                //                 $(container).find('input[name*="[soldeCloture]"]').val(totalsomme);
                //             }

                //             $("#sold").html('<strong class="mx-10 mb-5 btn btn-outline btn-outline-dashed text-success" style="font-size:20px"> Solde = ' + thousands_separators(totalsomme) + ' F CFA</strong>');
                //         }

                //         blocmonnaie.find('input[name*="[nbr]"]').keyup(function () {
                //             var montant = 0;
                //             var nbr= parseFloat(blocmonnaie.find('input[name*="[nbr]"]').val());
                //             if(parseFloat(nbr) > 0){
                //                 montant= prix*nbr;
                //                 blocmonnaie.find('input[name*="[montant]"]').val(montant);
                //                 var totalsomme = 0;
                //                 let montantParmonnaie = $(".montant");
                //                 for(let i = 0; i < montantParmonnaie.length; i++) {
                //                     if($(montantParmonnaie[i]).val() !=''){
                //                         totalsomme += parseFloat($(montantParmonnaie[i]).val());
                //                     }
                //                 }
                //                 if(etatcaisse==="ouverture"){
                //                     $(container).find('input[name*="[fondRoulement]"]').val(totalsomme);
                //                 }else{
                //                     $(container).find('input[name*="[soldeCloture]"]').val(totalsomme);
                //                     $(container).find('input[name*="caisse[chiffreAffaire]"]').val(totalsomme- parseFloat($(container).find('input[name*="[fondRoulement]"]').val()));
                //                 }
                //                 $("#sold").html('<strong class="mx-10 mb-5 btn btn-outline btn-outline-dashed text-success" style="font-size:20px"> Solde = ' + thousands_separators(totalsomme) + ' F CFA</strong>');
                                
                                
                //             }else{

                //                 blocmonnaie.find('input[name*="[montant]"]').val(0);
                //                 blocmonnaie.find('input[name*="[nbr]"]').val('');
                //             }
                //         });



                //     })
                // }
            });
            caisse();
        }
    }

    function thousands_separators(num) {
        var num_parts = num.toString().split(".");
        num_parts[0] = num_parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, " ");
        return num_parts.join(".");
    }
    
    function calculemont(){
        $.each($($(container).find('input[name*="[nbr]"]')), function (i, elt) {      
            let input = $(elt);      
            input.keyup(function () {
                let blocmonnaie =input.parent().parent();
                selected=blocmonnaie.find('select[name*="[monnaie]"]').find('option:selected');
                valeur=selected.attr('data-valeur');
                console.log(selected,'selected',valeur);
                var montant = 0;
                var nbr= parseFloat(blocmonnaie.find('input[name*="[nbr]"]').val());
                var totalsomme = 0;
                let montantParmonnaie = $(".montant");
                if(parseFloat(nbr) > 0){
                    montant= valeur*nbr;
                    blocmonnaie.find('input[name*="[montant]"]').val(montant);
                }else{

                    blocmonnaie.find('input[name*="[montant]"]').val(0);
                    blocmonnaie.find('input[name*="[nbr]"]').val('0');
                }
                for(let i = 0; i < montantParmonnaie.length; i++) {
                    if($(montantParmonnaie[i]).val() !=''){
                        totalsomme += parseFloat($(montantParmonnaie[i]).val());
                    }
                }
                if(etatcaisse === "ouverture"){
                    $(container).find('input[name*="[fondRoulement]"]').val(totalsomme);
                } else {
                    $(container).find('input[name*="[soldeCloture]"]').val(totalsomme);
                    // $(container).find('input[name*="[depense]"]').val(totalsomme);
                    $(container).find('input[name*="caisse[ecart]"]').val(totalsomme - parseFloat($(container).find('input[name*="[fondRoulement]"]').val()) - parseFloat($(container).find('input[name*="[chiffreAffaire]"]').val()) + parseFloat($(container).find('input[name*="[depense]"]').val()));
                }
                $(".sold").html('<strong class="mx-10 mb-5 btn btn-outline btn-outline-dashed text-success" style="font-size:20px"> Solde = ' + thousands_separators(totalsomme) + ' F CFA</strong>');
            });
       });
    }
    
    var desactiverSelect=()=>{
        var mesoption=[];
        console.log(mesoption,selectedoptions,'mesoption');
        for(var key in selectedoptions) {
            mesoption.push(selectedoptions[key]);
        }
        $.each($(container).find('select.personnel'), function (i, elt) {
            console.log(elt,'elt',i);
            $.each($(elt).find('option:not(:selected)'), function(i, item) {
                //console.log(item.value,selectvalu);
                if ($.inArray($(this).val() , mesoption) != -1) {
                    $(item).prop("disabled", true);
                } else {
                    $(item).prop("disabled", false);
                }
            });
        }) 
    }


    function caisse() {
        desactiverSelect();
        if(container != null)
        {

            $.each($(container).find('select[name*="[personnel]"]'), function (i, elt) {
                var personnel = $(this);
                personnel.change(function () {
                    selectedoptions[personnel.attr('name')] = $(this).val();
                    console.log(selectedoptions,'selectedoptions');
                    desactiverSelect();
                })
            })
            
            //console.log('container',container.querySelectorAll('.add_caisse_item_link'));
            /*  $(container).find('.add_caisse_item_link').each(function () {
                $(this)
            })*/
            // console.log($(container).find('select[name*="[monnaie]"]'),'fggggggggggg');.select2("readonly", tr
            //$(container).find('select[name*="[monnaie]"]').select2("readonly", true);
            /*$.each($(container).find('select[name*="[monnaie]"]'), function (i, elt) {
                console.log($(elt),$(this))
                var select= $(elt);
                //$(select).trigger('change');
                //$(select).find('[data-control="select2"]').select2({disabled:'readonly'});
            })*/
            
            container.querySelectorAll('.add_caisse_item_link').forEach(btn => {
            console.log("click",btn);
            btn.addEventListener("click", addFormToCollection);
            const holders = document.querySelectorAll('.' + btn.dataset.collectionHolderClass);
                holders.forEach(h => {
                    const divs = h.querySelectorAll('div');
                    divs.forEach(div => {
                        addFormDeleteLink(div);
                    });
                });
            });
        }
    }

    return {
        init: function() {
            caisse();
            calculemont()
        }
    }

}();
KTUtil.onDOMContentLoaded((function() {
    KTCaisse.init();
}));

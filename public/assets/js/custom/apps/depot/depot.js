
"use strict";
var GESTIONDEPOT = function() {
    var fieldList= new Object;
    var validation;
    var handlelistes = () => {
        const buttons = document.querySelectorAll('[data-kt-entity-table-filter="list"]');
        const bloc = document.querySelector('[data-call-form="ajax"]');
        console.log(buttons);
        console.log(bloc);
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
                        $(bloc).html(data.html);
                        const form = bloc.querySelector('form');
                        if(form){
                            form.querySelectorAll('select').forEach(s => {
                                $(s).select2();
                            });
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

    var swishModePaiement =(key)=>{
        let form = $(container).find('form');
        let virement = form.find('.virement').parent();
        let cheque = form.find('.cheque').parent();
        let mobilemoney = form.find('.mobilemoney').parent();
        //console.log(key,'key',cheque,)
        if (key) {
               if( key.includes('espèce')){
                    virement.hide();
                    cheque.hide();
                    mobilemoney.hide();
                    console.log('espèce',cheque)
               }
               if( key.includes('Chèque')){
                     mobilemoney.hide();
                     cheque.show();
                     cheque.find('input').attr('required',true);
                     console.log('Chèque',cheque);
               }
                if( key.includes('Virement')){
                    cheque.hide();
                    mobilemoney.hide();
                    virement.show();
                    virement.find('input').attr('required',true);
                    console.log('virement',cheque,)
               }
                if( key.includes('Mobile Money')){
                     virement.hide();
                     cheque.hide();
                     mobilemoney.show();
                     mobilemoney.find('input').attr('required',true);
                }
        }else{
            virement.hide();
            cheque.hide();
            mobilemoney.hide();
        }
               
    }
    
    var loadnewForm =()=>{
        console.log('newform',newform);
       if($(container).find('form').attr('action') === undefined ){
          $(newform).find().find('[data-control="select2"]').select2();
          $(container).html(newform);
          $(container).find('[data-control="select2"]').select2();
       }
    }
    const initializeContainer = () => {
        let parent = container;
        $(parent).find('[data-control="select2"]').select2();
        const btnS = container.querySelectorAll('button[type="submit"]');
        if(btnS != null)
        {
            btnS.forEach(btn => {
                const form = btn.closest('form');
                if (form != null && form != undefined) {
                    validation = valitation(form,fieldList)
                    btn.addEventListener("click", function(e) {
                        console.log(form,'form');
                        e.preventDefault();
                        var erreur = false;
                        if($(this).hasClass("imprimer") == true){
                            $("#depot_truc").val("OUI");
                            console.log("Oui");
                        }else{
                            e.preventDefault();
                            $("#depot_truc").val("NON");
                            console.log("Non");   
                        }
                        save(form,validation,btn,erreur);
                    });
                }
            });
        }

        let seletcom = $(container).find('select[name*="depot[modePaiement]"]');
        var selected = $(seletcom).find('option:selected').val();
        var selectedtext = $(seletcom).find('option:selected').text();
        if(seletcom){
            seletcom.change(function(){
                selected = $(this).find('option:selected').val();
                selectedtext = $(seletcom).find('option:selected').text();
                console.log(selectedtext);
                swishModePaiement(selectedtext);
                
            });
        }
        const addbtn = document.querySelector('[data-kt-entity-table-filter="new_form"]');
        console.log('addbtn',addbtn)
        addbtn.addEventListener('click', function (e) {
            console.log('click',addbtn)
            loadnewForm();
            initializeContainer();
            swishModePaiement('');
        });
    }

    return {
        init: function() {
            loadnewForm();
            initializeContainer();
            handlelistes();
            swishModePaiement('');
        }
    }
}();
KTUtil.onDOMContentLoaded((function() {
    GESTIONDEPOT.init();
}));
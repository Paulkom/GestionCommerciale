

function produit(element) {
    //currentForm = container.querySelector('form[name*="produit"]');
    const numMediaFields = element.querySelectorAll('input[name*="numMedia"]');
    numMediaFields.forEach(i => {
        if(i.getAttribute('name').includes('produit'))
        {
            const numMediaParentDiv = i.closest('div');
            numMediaParentDiv.classList.add('d-none');
        }
    });
    const fileFields = element.querySelectorAll('input[name*="file"]');
    fileFields.forEach(j => {
        if(j.getAttribute('name').includes('produit'))
        {
            const fileParentDiv = j.closest('div');
            fileParentDiv.classList.remove('col-sm-7');
            fileParentDiv.classList.add('col-sm-11');
        }
    });

    groupeTaxes(element);
    checkRegime();

}


function checkRegime(){
    
    $( document ).ready(function() {
        let regime = $('input#regime').val();
        if(regime == 1){
            let groupeTaxe = $('select#produit_groupeTaxe');
            groupeTaxe.val(7);
            groupeTaxe.select2({disabled: true});

            let mode = $('select#produit_modeDefPrix');
            mode.val(0);
            mode.select2({disabled: true});

            let estTaxable = $('input#produit_estTaxable');
            estTaxable.attr("checked",false);
            estTaxable.on('click', function(){ return false});    
        }

    });

}

function checkEstService(){
    // cas de modification
    let form = $(container).find('form');
    
    let chek = document.querySelector('input[name="produit[estService]"]');

    if(chek != null && chek.checked){
        let element = $(form).find('#ignoreInEstService');
        element.addClass("d-none");
       
        // console.log(element);
        fields = $(form).find('input.ignoreInEstService, select.ignoreInEstService');
        fields.each((o, el) => {
            if($(el).prop('required')){
                validation.removeField($(el).attr('name'));
                $(el).removeClass('is-invalid');
                $(el).parent().find('.form-label').removeClass('required');
            }
        })
        
    }
}

function checkEstCarreau()
{
    // cas de modification
    let form = $(container).find('form');
    let chek = document.querySelector('input[name="produit[estModeCarreau]"]');

    if(chek != null && chek.checked){
        let infoCarreau = $(form).find('#infoCarreau');
        infoCarreau.removeClass("d-none");

        $.each($(form).find('.carreau'), function (i, elt) {
            $(elt).prop('required', 'required');
            validation.addField($(elt).attr('name'),{
                validators: {
                    notEmpty: {
                        message: $(elt).prev().text()+' est obligatoire'
                    }
                }
            })
            $(elt).parent().find('.form-label').addClass('required');
        })

    }
}



function groupeTaxes(element)
{
    const groupeTaxes = element.querySelectorAll('select[name*="groupeTaxe"], select[name*="modeDefPrix"]');
    let b = false, c = false;
    groupeTaxes.forEach(g => {
        if(!(g.value !== ""))
        {
            // element.querySelectorAll('.add_item_link').forEach(a => {
            //     if(a.innerText.includes('conditionnement'))
            //         a.classList.add('d-none');
            // });
        }else{

            let optionValue = g.selectedOptions[0].innerText;
            elementGroupeTaxe( optionValue, element);

        }
        $(g).select2().on('change', function () {
            if(this.selectedOptions.length > 0)
            {
                const option = this.selectedOptions[0];
                const tax = option.dataset.taux;
                const mode = element.querySelector('select[name*="modeDefPrix"]');
                
                element.querySelectorAll('.add_item_link').forEach(a => {
                    if(g.getAttribute('name').includes('modeDefPrix'))
                        b = true;
                    if(g.getAttribute('name').includes('groupeTaxe'))
                        c = true;
                    if(a.innerText.includes('conditionnement') && (b && c))
                        a.classList.remove('d-none');
                });

                let estTaxable = element.parentElement.querySelector('input[name*="estTaxable"]');
                let modePrix = element.parentElement.querySelector('select[name*="modeDefPrix"]');
                $(modePrix).select2({disabled: false});
                estTaxable.onclick = function(){ return true };
                let optionValue = option.innerText;

                elementGroupeTaxe(optionValue, element, estTaxable, modePrix );

                element.querySelectorAll('input[name*="prixDeVenteHT"]').forEach(i => {
                    const parent = i.closest('div.form-child');
                    const prixVenteField = parent.querySelector('input[name*="prixDeVente"]');
                    const prixVenteHTField = parent.querySelector('input[name*="prixDeVenteHT"]');
                    const prixVenteTTCField = parent.querySelector('input[name*="prixDeVenteTTC"]');
                    if(isFloat(prixVenteField.value) && mode.value !== "")
                    {
                        if(parseInt(mode.value) === 0)
                        {
                            prixVenteHTField.value = prixVenteField.value;
                            prixVenteTTCField.value = parseFloat(prixVenteHTField.value) * (1 + parseFloat(tax));
                        }

                        if(parseInt(mode.value) === 1)
                        {
                            prixVenteTTCField.value = prixVenteField.value;
                            prixVenteHTField.value = (100 * parseFloat(prixVenteTTCField.value)) / (100 + (parseFloat(tax) * 100));
                        }
                        console.log('Mode : ', mode.value);
                        console.log('Prix de vente HT : ', prixVenteHTField.value);
                        console.log('Prix de vente TTC 1: ', prixVenteTTCField.value);
                    }
                });
            }
        });
    });
}

function elementGroupeTaxe( optionValue , element, estTaxable = null, modePrix = null,){

    estTaxable  = estTaxable ?? element.parentElement.querySelector('input[name*="estTaxable"]');
    modePrix    = modePrix ?? element.parentElement.querySelector('select[name*="modeDefPrix"]');
    
    switch (optionValue) {

        case 'HT':
            break;

        case 'TTC':
            estTaxable.checked = true;
            estTaxable.onclick = function(){ return false };
            break;

        case 'A - EXONERE':
            estTaxable.checked = false;
            estTaxable.onclick = function(){ return false };
            modePrix.value = '0';
            $(modePrix).select2();
            $(modePrix).select2({disabled: true});
            break;

        case 'B - TAXABLE 18%':
            estTaxable.checked = true;
            modePrix.value = '1';
            $(modePrix).select2();
            break;
        
        case 'C - EXPORTATION':
            estTaxable.checked = false;
            estTaxable.onclick = function(){ return false };
            modePrix.value = '0';
            $(modePrix).select2();
            $(modePrix).select2({disabled: true});
            break;
        
        case 'D - TVA REGIME D\'EXCEPTION 18%':
            estTaxable.checked = true;
            estTaxable.onclick = function(){ return false };
            modePrix.value = '1';
            $(modePrix).select2();
            $(modePrix).select2({disabled: true});
            break;
        
        case 'E - REGIME TPS':
            estTaxable.checked = false;
            estTaxable.onclick = function(){ return false };
            modePrix.value = '0';
            $(modePrix).select2();
            $(modePrix).select2({disabled: true});
            break;

        case 'F - RESERVE':
            estTaxable.checked = false;
            estTaxable.onclick = function(){ return false };
            modePrix.value = '0';
            $(modePrix).select2();
            $(modePrix).select2({disabled: true});
            break;
    
        default:
            console.log(optionValue);
            break;
    }
}

function controlesProduit(e)
{
    let form = $(container).find('form');
    if($(form).attr('name') == "produit"){
    
        let val = "0";
        const elt = e.target;
        const name = elt.getAttribute('name');
        const parent = elt.closest('div.form-child');
        if(elt.value !== "")
            val = elt.value;
        if(parent != null)
        {
            let erreur = false;
            let msg = '';
            let errorTag = parent.querySelector('.' + parent.getAttribute('id'));
            if(name.includes('produit'))
            {
                const prixMinField = parent.querySelector('input[name*="prixMin"]');
                const prixVenteField = parent.querySelector('input[name*="prixDeVente"]');
                const prixVenteHTField = parent.querySelector('input[name*="prixDeVenteHT"]');
                const prixVenteTTCField = parent.querySelector('input[name*="prixDeVenteTTC"]');
                const prixMaxField = parent.querySelector('input[name*="prixMax"]');

                var conditionnement = parent.querySelector('select[name*="conditionnement"]');
                const qteCond = parent.querySelector('input[name*="qteCond"]');
                // console.log(conditionnement.options[conditionnement.selectedIndex].dataset.valeur);
                if(conditionnement.options[conditionnement.selectedIndex].dataset.valeur !=''){
                    qteCond.value = conditionnement.options[conditionnement.selectedIndex].dataset.valeur;
                }

                // prixVenteField.focus();
                
                // if(conditionnement.options[conditionnement.selectedIndex].dataset.valeur)
                //     prixVenteField.focus();


                if(!(errorTag !== null))
                {
                    errorTag = document.createElement('span');
                    errorTag.classList.add(parent.getAttribute('id'));
                    errorTag.classList.add('mx-auto');
                    errorTag.classList.add('badge');
                    errorTag.classList.add('bg-warning');
                    errorTag.classList.add('mt-2');
                    errorTag.classList.add('align-items-center');
                    if ('nextSibling' in parent.firstChild && parent.firstChild.nextSibling !== null)
                        parent.firstChild.nextSibling.appendChild(errorTag);
                    else
                        parent.firstChild.appendChild(errorTag);
                }

                if(name.includes('prixDeVente'))
                {
                    if(
                        (parseFloat(val) > parseFloat(prixMaxField.value) ||
                        parseFloat(val) < parseFloat(prixMinField.value)) &&
                        parseFloat(prixMinField.value) < parseFloat(prixMaxField.value)
                    )
                    {
                        erreur = true;
                        msg = `Prix de Vente : La valeur saisie doit être comprise entre ${parseFloat(prixMinField.value)} et ${parseFloat(prixMaxField.value)}.` ;
                    }
                    else if(
                        (parseFloat(val) > parseFloat(prixMaxField.value) ||
                        parseFloat(val) < parseFloat(prixMinField.value)) &&
                        parseFloat(prixMinField.value) > parseFloat(prixMaxField.value)
                    )
                    {
                        erreur = true;
                        msg = `Prix Min être strictement inférieure à Prix Max.` ;
                    }
                    else
                    {
                        erreur = false;
                    }

                    const mode = container.querySelector('select[name*="modeDefPrix"]');
                    const groupeTaxe = container.querySelector('select[name*="groupeTaxe"]');
                    const option = groupeTaxe.selectedOptions[0];
                    const tax = option.dataset.taux;

                    if(mode.value !== "" && groupeTaxe.value !== "")
                    {
                        if(isFloat(prixVenteField.value))
                        {
                            if(parseInt(mode.value) === 0)
                            {
                                prixVenteHTField.value = val;
                                prixVenteTTCField.value = parseFloat(prixVenteHTField.value) * (1 + parseFloat(tax));
                            }

                            if(parseInt(mode.value) === 1)
                            {
                                prixVenteTTCField.value = prixVenteField.value;
                                prixVenteHTField.value = (100 * parseFloat(prixVenteTTCField.value)) / (100 + (parseFloat(tax) * 100));
                            }
                            console.log('Mode : ', mode.value);
                            console.log('Prix de vente HT : ', prixVenteHTField.value);
                            console.log('Prix de vente TTC 2: ', prixVenteTTCField.value);
                        }
                    }
                }

                if(name.includes('prixMin'))
                {
                    if(parseFloat(val) >= parseFloat(prixMaxField.value))
                    {
                        erreur = true;
                        msg = `Prix Min : La valeur saisie doit être strictement inférieure à ${parseFloat(prixMaxField.value)}.` ;
                    }
                    else if(
                        parseFloat(prixVenteField.value) > parseFloat(prixMaxField.value) ||
                        parseFloat(prixVenteField.value) < parseFloat(val)
                    )
                    {
                        erreur = true;
                        msg = `Prix de Vente : La valeur saisie doit être comprise entre ${parseFloat(prixMinField.value)} et ${parseFloat(prixMaxField.value)}.` ;
                    }
                    else
                    {
                        erreur = false;
                    }
                }

                if(name.includes('prixMax'))
                {
                    if(parseFloat(val) <= parseFloat(prixMinField.value))
                    {
                        erreur = true;
                        msg = `Prix Max : La valeur saisie doit être strictement supérieure à ${parseFloat(prixMinField.value)}.` ;
                    }
                    else if(
                        parseFloat(prixVenteField.value) > parseFloat(val) ||
                        parseFloat(prixVenteField.value) < parseFloat(prixMinField.value)
                    )
                    {
                        erreur = true;
                        msg = `Prix de Vente : La valeur saisie doit être comprise entre ${parseFloat(prixMinField.value)} et ${parseFloat(prixMaxField.value)}.` ;
                    }
                    else
                    {
                        erreur = false;
                    }
                }

                if(erreur)
                {
                    parent.querySelector('.' + parent.getAttribute('id')).innerText = msg ;
                    form_children_controls[parent.getAttribute('id')][name] = false;
                    
                    $(container).find('button[type="submit"]').prop("disabled",true);
                    return false;
                }
                else
                {
                    parent.querySelector('.' + parent.getAttribute('id')).innerText = '';
                    form_children_controls[parent.getAttribute('id')][name] = true;
                    
                    $(container).find('button[type="submit"]').prop("disabled",false);
                }
            }
        }
    }
}

function showProduit(e) {
    e.preventDefault();
    const contenu = e.target.dataset.content;
    const idMenu = ($(contenu)[0]).dataset.menu;
    const menu = document.querySelector(`#${idMenu}`);
    menu.dataset.content = contenu;
    $(menu).trigger('click');
    menu.classList.remove('d-none');
    
}





function inventaireChildren(collectionHolder = null) {

    // console.log($(container).find('input#cloturer'));
    if($(container).find('input#cloturer').val() == 'cloture'){

        $(container).find('input').prop('readonly', true);
        $(container).find('textarea').prop('readonly', true);
        $(container).find('select').select2({disabled: true});
        $(container).find('.add_item_link').hide();
        console.log($(container).find('.collection-action').hide());
        
        $(container).find('form').on('submit', function(){
            console.log('uhu');
            $(container).find('input').prop('readonly', false);
            $(container).find('textarea').prop('readonly', false);
            $(container).find('select').select2({disabled: false});
        });
    }

    let parent = container;
    if(collectionHolder != null)
        parent = collectionHolder;
    if(parent != null)
    {
        const allMagasinSelects = parent.querySelectorAll('select[name*="magasin"]');
        allMagasinSelects.forEach(m => {
            const name = m.getAttribute('name');
            const parentDiv = m.closest('div.form-child');
            if(name.includes('inventaireMags'))
            {
                $(m).select2({
                    // allowClear: true,
                    minimumInputLength: 1,
                    placeholder: "Sélectionnez un magasin...",
                    language: {
                        inputTooShort: function(args) {
                            return "Entrez au moins un (01) caractère";
                        },
                        errorLoading: function() {
                            return "Erreur de chargement";
                        },
                        loadingMore: function() {
                            return "Charger plus de données";
                        },
                        noResults: function() {
                            return "Aucun résultat trouvé";
                        },
                        searching: function() {
                            return "Patientez...";
                        }
                    },
                    ajax: {
                        url: loadMagasinSortieSelectUrl,
                        dataType: 'json',
                        data: function (params) {
                            return {
                                search: params.term,
                                type: 'public',
                            };
                        },
                        processResults: function (response) {

                             // empêcher la sélection du même magasin
                             var selects = $('select[name*="magasin"]'), 
                             svals = selects.find("option:disabled").prop("disabled",false).end().find("option:selected").map(function(){
                                 if(this.value){ return $(this).val(); }
                             }).get();
                             
                             response.forEach(e => {
                                 var index = Object.values(svals).indexOf(String(e.id));
                                 if (index !== -1) {
                                     e['disabled'] = true;
                                 }
                             });
                             // fin

                            return {
                                results: response
                            };
                        },
                        cache: true
                    },
                    templateSelection: function (data, container) {
                        if(parentDiv !== null)
                            form_children_controls[parentDiv.getAttribute('id')][m.getAttribute('name')] = data.id !== "";
                        return data.text;
                    }
                });
            }
        });
        const allProduitSelects = parent.querySelectorAll('select[name*="produitCond"]');
        allProduitSelects.forEach(p => {
            const name = p.getAttribute('name');
            if(name.includes('inventaireMags')) {
                const parentDiv = p.closest('div.form-child');
                const magParent = $(parentDiv).parents('div.form-child')[0];
                const mag = magParent.querySelector('select[name*="magasin"]');
                $(p).select2({
                    minimumInputLength: 1,
                    placeholder: "Sélectionnez un produit...",
                    language: {
                        inputTooShort: function(args) {
                            return "Entrez au moins un (01) caractère";
                        },
                        errorLoading: function() {
                            return "Erreur de chargement";
                        },
                        loadingMore: function() {
                            return "Charger plus de données";
                        },
                        noResults: function() {
                            return "Aucun résultat trouvé";
                        },
                        searching: function () {
                            return "Patientez...";
                        }
                    },
                    ajax: {
                        url: loadProduitCondSortieSelectUrl,
                        dataType: 'json',
                        data: function (params) {
                            return {
                                search: params.term,
                                type: 'public',
                                id: mag != null ? mag.value : 0,
                            };
                        },
                        processResults: function (response) {

                            // empêcher la sélection du même produit conditionnement
                            var selects = $('select[name*="produitCond"]'), 
                            svals = selects.find("option:disabled").prop("disabled",false).end().find("option:selected").map(function(){
                                if(this.value){ return $(this).attr('data-magProdCondId'); }
                            }).get();
                            
                            response.forEach(e => {
                                var index = Object.values(svals).indexOf(String(e.magasinProduitConId));
                                if (index !== -1) {
                                    e['disabled'] = true;
                                }
                            });
                            // fin

                            return {
                                results: response
                            };
                        },
                        cache: true
                    },
                    templateSelection: function (data, container) {
                        if (parentDiv !== null)
                            form_children_controls[parentDiv.getAttribute('id')][p.getAttribute('name')] = data.id !== "";
                        const champPrix = parentDiv.querySelector('input[name*="prixUnitaire"]');
                        const champQte = parentDiv.querySelector('input[name*="qteCondStockLog"]');
                        /*if (champPrix !== null)
                            champPrix.focus();*/
                        if (champQte !== null)
                            champQte.focus();
                        if (typeof data.prixDeVenteTTC !== "undefined") {
                            // Add custom attributes to the <option> tag for the selected option
                            $(data.element).attr('data-prix-vente', data.prixDeVenteTTC);
                            $(data.element).attr('data-stock-mag', data.qteStockMag);
                            $(data.element).attr('data-stock-global', data.qteStockCond);
                            $(data.element).attr('data-magProdCondId', data.magasinProduitConId);

                            //Initialiser le champ prix de vente
                            //champPrix.value = typeof data.prixDeVenteTTC !== "undefined" ? data.prixDeVenteTTC : 0;

                            //Initialiser le champ Qté
                            champQte.placeholder = champQte.value = typeof data.qteStockMag !== "undefined" ? data.qteStockMag : 0;
                        } else {
                            if (
                                typeof data !== "undefined" &&
                                typeof data.element !== "undefined" &&
                                typeof data.element.dataset !== "undefined" &&
                                typeof data.element.dataset.stockMag !== "undefined"
                            ) {
                                //Initialiser le champ prix de vente
                                //champPrix.value = typeof data.element.dataset.prixVente !== "undefined" ? data.element.dataset.prixVente : 0;

                                //Initialiser le champ Qté
                                champQte.placeholder = champQte.value = typeof data.element.dataset.stockMag !== "undefined" ? data.element.dataset.stockMag : 0;
                            }
                        }
                        /*if (champPrix !== null)
                            $(champPrix).trigger('focusout');*/
                        if (champQte !== null)
                            $(champQte).trigger('focusout');
                        return data.text;
                    }
                });
            }
        });
    }
}

function controlesInventaire(e)
{
    let val = "0";
    const elt = e.target;
    const name = elt.getAttribute('name');
    const parent = elt.closest('div.form-child');
    if(elt.value !== "")
        val = elt.value;
    if(parent != null)
    {
        currentForm = parent.closest('form[name*="sortie"]');
        if(name.includes('magasin') && name.includes('inventaire'))
        {
            const totalField = container.querySelector('input.total');
            const allParentDiv = parent.querySelectorAll('div.form-child');
            allParentDiv.forEach(div => {
                //console.log(div);
                if(div.getAttribute('id') !== parent.getAttribute('id')) {
                    div.remove();
                    delete form_children[div.getAttribute('id')];
                    delete form_children_controls[div.getAttribute('id')];
                }
            });

            if(totalField != null)
                totalField.value = 0;
            //calculMontant('sortie', 'prixUnitaire', 'qteCondSortie');
        }

        if(name.includes('qteCondStockPhy') && name.includes('inventaire'))
        {
            const champQteLog = parent.querySelector('input[name*="qteCondStockLog"]');
            const champEcart = parent.querySelector('input[name*="ecart"]');
            if(isFloat(val) && isFloat(champQteLog.value))
            {
                const ecart = parseFloat(val) - parseFloat(champQteLog.value);
                champEcart.value = ecart;
                console.log('Ecart : ', ecart);
            }
        }
    }
}

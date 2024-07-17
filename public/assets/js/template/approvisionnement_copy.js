$(document).ready(function() { 

    let btnMagasin = $("button.o");
    checkEnableTOSave();

    btnMagasin.on('click', function(){
        

        $('.form-child').each(function(){
            var btnAddProduit =  $(".add_item_link.os");
            // btnAddProduit.prop("disabled",true);
            btnMagasin.prop("disabled",true);

            $(this).find('select').on('change', function(){
                console.log('yes');
                if($(this).val() != ''){
                    btnMagasin.prop("disabled",false);
                    // btnAddProduit.prop("disabled",false);
                    btnAddProduit.parent().find('span').remove();
                    checkEnableTOSave();
                }else{
                    btnMagasin.prop("disabled",true);
                } 

                // btnAddProduit.on('click', function(){
                //     $(this).prop("disabled",true);
                // });

                $('.os').on('click', function(){

                    var element = $(this).parents('.form-child');
                    // $(this).prop("disabled",true);

                    $('a.btn-danger').on('click', function(){
                        checkEnableTOSave();
                        // btnAddProduit.prop("disabled",false);
                        // console.log($('select[name*="produitCondtionnement"]:not(:selected)'));
                    });

                    element.find('select.produitCond').on('change', function(){

                        $(this).closest('.form-child').find('.text-muted').html('');
                        $(this).closest('.form-child').find('input[name*="qteCondAppro"]').val('');

                        if($(this).val() != ''){
                            // btnAddProduit.prop("disabled",false);
                            $(this).closest('.form-child').find('.prix').focus();
                            checkEnableTOSave();
                        }else{
                            // btnAddProduit.prop("disabled",true);
                            
                        } 
                        
                    });

                    element.find('input.quantite').on('keyup', function(){
                        
                        let _produitCond = element.find('select.produitCond option:selected');
                        let qte = $(this).val();

                        if(_produitCond.attr('est-mode-carreau') == 1){
                            
                            
                            if(_produitCond.val() != '' && _produitCond.val() > 0 ){ // si le conditionnement est pris
                                
                                // let spp = _produitCond.attr('surface-par-piece');
                                let ppc = _produitCond.attr('piece-par-carton');
                                let m2pc = _produitCond.attr('m2-par-carton');

                                let result = calculPieceCarton(qte, ppc, m2pc);
                                console.log(result['carton']);

                                $(this).closest('.row').find('input[name*="carton"]').val(result['carton']);
                                $(this).closest('.row').find('input[name*="piece"]').val(result['piece']);
                                $(this).closest('.form-child').find('.text-muted').html( result['carton'] + ' Carts ' + result['piece'] + ' pièces' );
                            }
                            
                        }

                    });


                });

            });

        });
    });

    // $('a.collection-action').on('click', function(){
        // $('select[name*="magasin"]').trigger('click');

        // console.log($('select[name*="produitCondtionnement"]:not(:selected)'));
        // $('select[name*="produitConditionnement"]').trigger('click');
    // });

   
});


function checkEnableTOSave(){
    
    var NbOptionSelected = $('select.produitCond').find(':selected');
   
    if(NbOptionSelected.length > 0){
        $('button[type="submit"]').attr('disabled',false);
        // console.log('autorisé');
    }else{
        $('button[type="submit"]').attr('disabled',true);
        // console.log('non autorisé');
    }   
    
}


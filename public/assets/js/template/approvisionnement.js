
$(document).ready(function() { 

    let btnMagasin = $("button.o");
    checkEnableTOSave();

    btnMagasin.on('click', function(){
       
        $('.form-child.magasin').each(function(){
            var magasin = $(this);
            var btnAddProduit =  $(this).find(".add_item_link.os");
            

            $('.os').on('click', function(){
                $(magasin.find('.form-child')).each(function(){

                    let _estCarreau = null;
                    let ppc = null;
                    let m2pc =null;
                    $(this).find('select.produitCond').on('change', function(){
                        if($(this).val() != ''){
                            // btnAddProduit.prop("disabled",false);
                            $(this).closest('.form-child').find('.prix').focus();
                            checkEnableTOSave();
                            _estCarreau = $(this).find('option:selected').attr('est-mode-carreau');
                            ppc =           $(this).find('option:selected').attr('piece-par-carton');
                            m2pc =          $(this).find('option:selected').attr('m2-par-carton');
                            
                        }
                    });

                    $(this).find('input.quantite').on('keyup', function(){
                        
                        // let _produitCond = element.find('select.produitCond option:selected');
                        let qte = $(this).val();

                        if(_estCarreau == 1){

                                let result = calculPieceCarton(qte, ppc, m2pc);
                                

                                $(this).closest('.row').find('input[name*="carton"]').val(result['carton']);
                                $(this).closest('.row').find('input[name*="piece"]').val(result['piece']);
                                $(this).closest('.form-child').find('.text-muted').html( result['carton'] + ' Carts ' + result['piece'] + ' pièces' );
                            
                            
                        }

                    });

                });
            });

        });

    });
    

});

function checkEnableTOSave(){
    
    var NbOptionSelected = $('select.produitCond').find(':selected');
    if(NbOptionSelected.length > 0){
        $('button[type="submit"]').attr('disabled',false);
        // console.log('yes');
    }else{
        $('button[type="submit"]').attr('disabled',true);
        // console.log('no');
    }   
    
}

function swishStatut(fieldList,validation){
    let form = $(container).find('form');
    
    if(form.attr('name') == 'fournisseur'){
    
        let moral = form.find('.moral').parent();
        let physique = form.find('.physique').parent();
        //initializeContainer();
        if(form.find('input[type=radio]:checked').val() == 'Physique')
            moral.hide();
        if(form.find('input[type=radio]:checked').val() == 'Moral')
            physique.hide();

        $.each($(form.find('.physique')), function (i, elt) {
            if($(elt).attr('name').includes('[dateNais]') == false){
                $(elt).prop('required', 'required');
                validation.addField($(elt).attr('name'),{
                    validators: {
                        notEmpty: {
                            message: $(elt).prev().text()+' est obligatoire'
                        }
                    }
                })
                $(elt).parent().find('.form-label').addClass('required');
            }
        })
        form.find('input[type=radio]').change(function() {
            if (this.value == 'Physique') {
                moral.hide();
                physique.show();
                $.each($(form.find('.physique')), function (i, elt) {
                    $(elt).prop('required', 'required');
                    if($(elt).attr('name').includes('[dateNais]') == false){
                        $(elt).prop('required', 'required');
                        validation.addField($(elt).attr('name'),{
                            validators: {
                                notEmpty: {
                                    message: $(elt).prev().text()+' est obligatoire'
                                }
                            }
                        })
                    }
                })
                $.each($(form.find('.moral')), function (i, elt) {
                    $(elt).prop('required', '');
                    validation.removeField($(elt).attr('name'));
                    $(elt).removeClass('is-invalid');
                    $(elt).parent().find('.form-label').addClass('required');
                })
            }
            else if (this.value == 'Moral') {
                moral.show();
                physique.hide();
                $.each($(form.find('.physique')), function (i, elt) {
                    if($(elt).attr('name').includes('[dateNais]') == false){
                        $(elt).prop('required', '');
                        validation.removeField($(elt).attr('name'));
                        $(elt).removeClass('is-invalid');
                    }
                })
                $.each($(form.find('.moral')), function (i, elt) {
                    if($(elt).attr('name').includes('[dateNais]') == false){
                        $(elt).prop('required', 'required');
                        validation.addField($(elt).attr('name'),{
                            validators: {
                                notEmpty: {
                                    message: $(elt).prev().text()+' est obligatoire'
                                }
                            }
                        })
                        $(elt).parent().find('.form-label').addClass('required');
                    }
                })
            }
        });

    }

}
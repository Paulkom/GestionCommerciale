"use strict";
var GESTIONNAIRECOMPTE = function() {


   

    var loadnewForm =()=>{
        $("#kt_compte_form").on('click', function(){
            $(newform).find('[data-control="select2"]').select2();
            $(container).html(newform);
            $(container).find('[data-control="select2"]').select2(); 
        });
    }

return {
    init: function() {
        loadnewForm();
        // paiement();
       // handlelistes();
    }
}
}();
KTUtil.onDOMContentLoaded((function() {
GESTIONNAIRECOMPTE.init();
}));
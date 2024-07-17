"use strict";
var FAM = function() {

    var resetData = ()=>{
        $(document).ready(function() {

            $('#famille_codeFamille').maxlength({
                warningClass: "badge badge-warning",
                limitReachedClass: "badge badge-success"
            });
        });
    }

   
    return {
        init: function() {
            resetData();
        }
    }

}();
KTUtil.onDOMContentLoaded((function() {
    FAM.init();
}));

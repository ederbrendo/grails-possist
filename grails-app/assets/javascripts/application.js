// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better
// to create separate JavaScript files as needed.
//
//= require jquery/jquery.js
//= require bootstrap/js/bootstrap.js
//= require vue/vue.js
//= require vue-resource/vue-resource.js
//= require vuetable/dist/vue-table.js
//= require moment-with-locale.js
//= require bootstrap-datepicker/js/bootstrap-datepicker.min.js
//= require bootstrap-datepicker/js/bootstrap-datepicker.pt-BR.min.js
//= require vue-validator/vue-validator.js
//= require select2/select2.full.js
//= require select2/i18n/pt-BR.js
//= require moment/moment.js
//= require bootbox/bootbox.js
//= require jquery.maskedinput/jquery.maskedinput.js
//= require webcamjs-bower/webcam.js
//= require_self

Vue.config.warnExpressionErrors = false

var WBSAPP = function(){
    return {
        init: init,
        selectMenu: selectMenu,
        selectSideMenu: selectSideMenu
    };

    function init() {
        maskDate();
        select2Init();
        maskTelefone();
        maskCep();
        maskCpfCnpj();
    }
    function selectMenu(id){
        $(".wbs-main-tabs").find("li.active").removeClass("active");
        $(".wbs-main-tabs").find("li"+id).addClass("active");
    }

    function selectSideMenu(id){
        $(".wbs-sidebar .nav").find("li.active").removeClass("active");
        $(".wbs-sidebar .nav").find("li"+id).addClass("active");
    }

    function maskDate(){
        $("[datemask]").mask("99/99/9999");
        $("[datemask]").datepicker({language:'pt-BR',autoclose:true});
    }

    function maskTelefone(){
        $("[name^='telefone']").mask("(99) 9999-9999?9");
    }

    function maskCep(){
        $("[name='cep']").mask("99.999-999");
    }
    function maskCpfCnpj(){
        var cpfCnpjValue = $('[data-mask="cpfCnpj"]').val();
        if(cpfCnpjValue != "" && cpfCnpjValue != undefined){
            if(cpfCnpjValue.replace(/[^a-zA-Z 0-9]+/g,'').length == 11){
                $('[data-mask="cpfCnpj"]').mask("999.999.999-99?99999");
            }else{
                $('[data-mask="cpfCnpj"]').mask("99.999.999/9999-99");
            }
        }else{
            $('[data-mask="cpfCnpj"]').mask("99.999.999/9999-99");
        }
        $('[data-mask="cpfCnpj"]').on('keyup', function (e) {

            var query = $(this).val().replace(/[^a-zA-Z 0-9]+/g,'');

            if (query.length == 11) {
                $('[data-mask="cpfCnpj"]').mask("999.999.999-99?99999");
            }

            if (query.length == 14) {
                $('[data-mask="cpfCnpj"]').mask("99.999.999/9999-99");
            }
        });
    }
    function select2Init(){
        $("[select2]").select2();
    }
};

$(document).ready(function(){
    WBSAPP().init();
});
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//    
//= require jquery-2.2.3/dist/jquery
//= require bootstrap/dist/js/bootstrap
//= require fastclick/lib/fastclick 
//= require micromodal/dist/micromodal
//= require malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar
//= require nprogress/nprogress
//= require custom
//= require trix  
//= require jquery-ui/datepicker
//= require cocoon        
//= require bootbox  
//= require popper 
//= require alertify     
$(document).ready(function() {
    MicroModal.init();
  });
Trix.config.textAttributes.verde = { 
	style: { color: "#1abb9c" },
  parser: function(element) {
  	return element.style.color === "#1abb9c"
  },
  inheritable: true
 }  
addEventListener("trix-initialize", function(event) {   
    var buttonHTML = '<button type="button" data-trix-attribute="verde"><i class="fa fa-font" style="color:#1abb9c;font-size:20px"></i</button>' 
  
      event.target.toolbarElement.
        querySelector(".button_group.text_tools").
          insertAdjacentHTML("beforeend", buttonHTML)
  })
function modal(link) {
    MicroModal.init({  
        openTrigger: 'datacustomopen', // [3] 
        openClass: 'is-open', // [5] 
    }); 
    return false;
  }
alertify.defaults = {
    // dialogs defaults
    focusOn:'cancel',
    autoReset:true,
    basic:false,
    closable:true,
    closableByDimmer:true,
    invokeOnCloseOff:false,
    frameless:false,
    defaultFocusOff:true,
    maintainFocus:true, // <== global default not per instance, applies to all dialogs
    maximizable:true,
    modal:true,
    movable:true,
    moveBounded:false,
    overflow:true,
    padding: true,
    pinnable:true,
    pinned:true,
    preventBodyShift:false, // <== global default not per instance, applies to all dialogs
    resizable:true,
    startMaximized:false,
    transition:'pulse',
    transitionOff:false,
    tabbable:'button:not(:disabled):not(.ajs-reset),[href]:not(:disabled):not(.ajs-reset),input:not(:disabled):not(.ajs-reset),select:not(:disabled):not(.ajs-reset),textarea:not(:disabled):not(.ajs-reset),[tabindex]:not([tabindex^="-"]):not(:disabled):not(.ajs-reset)',  // <== global default not per instance, applies to all dialogs

    // notifier defaults
    notifier:{
    // auto-dismiss wait time (in seconds)  
        delay:5,
    // default position
        position:'bottom-right',
    // adds a close button to notifier messages
        closeButton: false,
    // provides the ability to rename notifier classes
        classes : {
            base: 'alertify-notifier',
            prefix:'ajs-',
            message: 'ajs-message',
            top: 'ajs-top',
            right: 'ajs-right',
            bottom: 'ajs-bottom',
            left: 'ajs-left',
            center: 'ajs-center',
            visible: 'ajs-visible',
            hidden: 'ajs-hidden',
            close: 'ajs-close'
        }
    },

    // language resources 
    glossary:{
        // dialogs default title
        title:'Confirmação',
        // ok button text
        ok: 'Sim, excluir',
        // cancel button text
        cancel: 'Cancelar'            
    },

    // theme settings
    theme:{
        // class name attached to prompt dialog input textbox.
        input:'ajs-input',
        // class name attached to ok button
        ok:'ajs-ok',
        // class name attached to cancel button 
        cancel:'ajs-cancel'
    },
    // global hooks
    hooks:{
        // invoked before initializing any dialog
        preinit:function(instance){},
        // invoked after initializing any dialog
        postinit:function(instance){},
    },
};  


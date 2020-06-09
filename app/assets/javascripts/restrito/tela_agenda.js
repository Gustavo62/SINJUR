# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
var initialize_calendar;
initialize_calendar = function(){
    $('.calendar').each(function(){
        var calendar = $(this);
    })
};
$(document).on('turbolinks:load', initialize_calendar);
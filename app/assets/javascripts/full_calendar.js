var initialize_calendar;
initialize_calendar = function(){
    $('.calendar').each(function(){
        var calendar = $(this);
    })
};
$(document).on('turbolinks:load', initialize_calendar);
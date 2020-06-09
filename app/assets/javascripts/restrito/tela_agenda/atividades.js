var initialize_calendar;
initialize_calendar = function(){
    $('.calendar').each(function(){
        var calendar = $(this);
    })
};
$(document).on('turbolinks:load', initialize_calendar);
$('button').on('click', function () {
    $(this).addClass('clicked');
});
$(document).ready(function(){
$("#event_event_time").datetimepicker(
    {
        showOn: 'both',
        dateFormat: 'yy-mm-dd',
        timeFormat: "HH:mm:ss",
        constrainInput: true
    });

});
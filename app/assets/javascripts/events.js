$(document).ready(function(){
    $("#event_event_time").datetimepicker(
        {
            dateFormat: 'yy-mm-dd',
            timeFormat: "HH:mm z",
            constrainInput: true,
            showTimezone: true
    });

    $('#new_event input,#new_event input').keydown(function(event){
        if(event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });

    $('#searchTangoKeyword').keydown(function(event){
        if(event.keyCode == 13) {
            $('#btnSearch').trigger('click');
        }
    });

    $('#btnGoWithDistance').live('click',function(){
        $('#btnSearch').trigger('click');
    });

    $('#btnSearch').live('click', function() {
        var keyword = $('#searchTangoKeyword').val().trim();
        if((keyword != '' && keyword.length>0) ||
            ($('#is_distance_range').is(':checked') && $('#search_location').val().trim().length>0 &&
                $('#search_longitude').val().trim().length>0 && $('#search_latitude').val().trim().length>0) ) {
            $.ajax({
                cache: false,
                type: 'POST',
                url: '/events/search',
                data: {
                    search_keyword: keyword,
                    is_distance_range:$('#is_distance_range').is(':checked'),
                    current_location: $('#search_location').val(),
                    search_latitude: $('#search_latitude').val(),
                    search_longitude: $('#search_longitude').val(),
                    distance_range: $('#search_range_km').val()
                },
                success: function(msg){
                }
            });
        }
    });

    $('.btnDelete').live('click', function() {
        var id = $(this).attr('id');
        if(id != '' && id.length>0) {
            $.ajax({
                cache: false,
                type: 'POST',
                url: '/events/remove',
                data: {
                    id: id
                },
                success: function(msg){
                }
            });
        }
    });

    $( "#range_slider").slider({
        range: 'min',
        min: 10,
        max: 500,
        step: 20,
        disabled: false,
        value: 150,
        slide: function(event, ui){
            $('#search_range_km').val(ui.value);
        },
        change: function(event, ui) {
            $('#search_range_km').val(ui.value);
        }
    });

    $('#is_distance_range').live('change',function(){
        if($(this).is(':checked')){
            $('#search_location').removeAttr('disabled');
            $('#searchTangoKeyword').attr('disabled','disabled');
        }else{
            $('#search_location').attr('disabled','disabled');
            $('#searchTangoKeyword').removeAttr('disabled');
        }
    });

});


function initGoogleLocationSearchFields(location_input_id, longitude_id, latitude_id) {

    var input = document.getElementById(location_input_id);

    var options = {
        types: ['(cities)']
    };

    autocomplete = new google.maps.places.Autocomplete(input, options);
    google.maps.event.addListener(autocomplete, 'place_changed', function() {
        var place = autocomplete.getPlace();
        $("#"+longitude_id).val(place.geometry.location.lng());
        $("#"+latitude_id).val(place.geometry.location.lat());
    });
}
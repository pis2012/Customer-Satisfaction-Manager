
function updatePanel(path, id_replace, tab) {
    $.get(path, function (response) {
        $('#' + id_replace).html(response);
        $('#myTab  a[href=#' + tab + ']').tab('show');
    }, 'html');
}

$(document).on('click', '.reports-link', function () {
    updatePanel($(this).data('url'), 'reports_data', 'reports');
    return false;
});

$(document).on('click', '.forms-link', function () {
    updatePanel($(this).data('url'), 'forms_data', 'forms');
    return false;
});

$(document).on('click', '.add-form-link', function () {
    updatePanel($(this).data('url'), 'add_form_data', 'add_form');
    return false;
});

$(document).on('click', '.show-form-link', function () {
    updatePanel($(this).data('url'), 'show_form_data', 'show_form');
    return false;
});

$(document).on('change', '#form_client', function() {
    $('#form_client_full_data').empty();
    $('#btn_full_data').hide();
    $('#form_client_data').empty();
    if (val != "")
    {
        var val = $(this).val();
        $.get($(this).data('url'), {client_name:val}, function(response) {
            $('#form_client_data').html(response);
            $('#btn_full_data').show();
        }, 'html');
    }
    return false;
});

$(document).on('click', '#btn_full_data', function() {
    var cn = $('#form_client').val();
    $.get($(this).data('url'), {client_name:cn}, function(response) {
        $('#form_client_full_data').html(response);
    }, 'html');
    return false;
});

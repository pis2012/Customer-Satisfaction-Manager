
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

$(document).on('click', '.clients-link', function () {
    updatePanel($(this).data('url'), 'client_data', 'clients');
    return false;
});

$(document).on('click', '.add-clients-link', function () {
    updatePanel($(this).data('url'), 'add_client_data', 'add_clients');
    return false;
});

$(document).on('click', '.show-client-link', function () {
    updatePanel($(this).data('url'), 'show_client_data', 'show_client');
    return false;
});
$(document).on('click', '.edit-client-link', function () {
    updatePanel($(this).data('url'), 'edit_client_data', 'edit_client');
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
    $('#btn_full_data').css("visibility","hidden");
    $('#form_client_data').empty();
    if (val != "")
    {
        var val = $(this).val();
        $.get($(this).data('url'), {client_name:val}, function(response) {
            $('#form_client_data').html(response);
            $('#btn_full_data').css("visibility","visible");
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

$('.new-user-link').live('click', function () {
    updatePanel($(this).attr('data-url'), 'new-user', 'new-user');
    return false;
});

$('.edit-user-link').live('click', function () {
    updatePanel($(this).attr('data-url'), 'edit-user', 'edit-user');
    return false;
});

$('.show-user-link').live('click', function () {
    updatePanel($(this).attr('data-url'), 'show-user', 'show-user');
    return false;
});

$('.users-link').live('click', function () {
    updatePanel($(this).attr('data-url'), 'users-content', 'users');
    return false;
});


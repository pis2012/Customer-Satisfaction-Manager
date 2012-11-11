
function updatePanel(path, id_replace, tab) {
    $.get(path, function (response) {
        $('#' + id_replace).html(response);
        $('#myTab  a[href=#' + tab + ']').tab('show');
    }, 'html');
}

//************** SUMMARY TAB **************** //

$(document).on('click', '.summary-link', function () {
    updatePanel($(this).data('url'), 'summary', 'summary');
    return false;
});


//************** REPORTS TAB **************** //

$(document).on('click', '.reports-link', function () {
    updatePanel($(this).data('url'), 'reports', 'reports');
    return false;
});

//************** PROJECTS TAB **************** //

$(document).on('show','#myTab a[href=#edit-project]', function (e) {
    $('#datepicker').datepicker();
});

$(document).on('show','#myTab a[href=#new-project]', function (e) {
    $('#datepicker').datepicker();
});

$(document).on('click', '.projects-link', function () {
    updatePanel($(this).data('url'), 'projects', 'projects');
    return false;
});

$(document).on('click', '.new-project-link', function () {
    updatePanel($(this).data('url'), 'new-project', 'new-project');
    return false;
});

$(document).on('click', '.edit-project-link', function () {
    updatePanel($(this).data('url'), 'edit-project', 'edit-project');
    return false;
});

//************** CLIENTS TAB **************** //

$(document).on('click', '.clients-link', function () {
    updatePanel($(this).data('url'), 'clients', 'clients');
    return false;
});

$(document).on('click', '.new-client-link', function () {
    updatePanel($(this).data('url'), 'new-client', 'new-client');
    return false;
});

$(document).on('click', '.show-client-link', function (e) {
    e.preventDefault();
    $('#myTab  a[href=#clients]').tab('show');
    updatePanel($(this).data('url'), 'show-client', 'show-client');
    return false;
});
$(document).on('click', '.edit-client-link', function () {
    updatePanel($(this).data('url'), 'edit-client', 'edit-client');
    return false;
});

//************** FORMS TAB **************** //


$(document).on('click', '.forms-link', function () {
    updatePanel($(this).data('url'), 'forms', 'forms');
    return false;
});

$(document).on('click', '.new-form-link', function () {
    updatePanel($(this).data('url'), 'new-form', 'new-form');
    return false;
});

function updatePanelForm(path, client, id_replace, tab)
{
    $.get(path, {client_name:client}, function (response) {
        $('#myTab  a[href=#forms]').tab('show');
        $('#forms').empty();
        $('#myTab  a[href=#' + tab + ']').tab('show');
        $('#' + id_replace).html(response);
        $('#form_client').val(client);
    }, 'html');
}

$(document).on('click', '.show-form-link', function () {
    updatePanelForm($(this).data('url'), "", 'show-form', 'show-form');
    return false;
});

$(document).on('click', '.show-form-link-alt', function () {
    updatePanelForm($(this).data('url'), $(this).data('client'), 'show-form', 'show-form');
    return false;
});


$(document).on('change', '#form_client', function() {
    $('#form_client_full_data').empty();
    $('#btn_full_data').css("visibility","hidden");
    $('#form_client_data').empty();
    var val = $(this).val();
    $.get($(this).data('url'), {client_name:val}, function(response) {
        $('#form_client_data').html(response);
        $('#btn_full_data').css("visibility","visible");
    }, 'html');
    return false;
});

$(document).on('click', '#btn_full_data', function() {
    var cn = $('#form_client').val();
    $.get($(this).data('url'), {client_name:cn}, function(response) {
        $('#form_client_full_data').html(response);
    }, 'html');
    return false;
});

$(document).on('click', '#form_filter_btn', function() {
    var forms_table_items = $("#forms_list .form_item");
    forms_table_items.each(function() {
        var name_filter = $('#form_name_filter').val();
        var name = $(this).attr("id");
        if (name.indexOf(name_filter) == -1) //name_filter not in form's name
        {
            $(this).css("visibility","hidden");
        }
        else
        {
            $(this).css("visibility","visible");
        }
    });
    return false;
});

//************** USERS TAB **************** //

$(document).on('click', '.new-user-link', function () {
    updatePanel($(this).attr('data-url'), 'new-user', 'new-user');
    return false;
});

$(document).on('click', '.edit-user-link', function () {
    updatePanel($(this).attr('data-url'), 'edit-user', 'edit-user');
    return false;
});

$(document).on('click', '.show-user-link', function (e) {
    e.preventDefault();
    $('#myTab  a[href=#users]').tab('show');
    updatePanel($(this).attr('data-url'), 'show-user', 'show-user');
    return false;
});

$(document).on('click', '.users-link', function () {
    updatePanel($(this).attr('data-url'), 'users', 'users');
    return false;
});

//************** EMAILS TAB **************** //

$(document).on('click', '.emails-link', function () {
    updatePanel($(this).attr('data-url'), 'emails', 'emails');
    return false;
});


$(document).on({
    ajaxStart: function() {
        $(".loading-gif").css("visibility","visible");
    },
    ajaxStop: function() {
        $(".loading-gif").css("visibility","hidden");
    }
});





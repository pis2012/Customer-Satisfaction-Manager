
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
    updatePanel($(this).data('url'), 'reports_data', 'reports');
    return false;
});

//************** PROJECTS TAB **************** //

$(document).on('click', '.projects-link', function () {
    updatePanel($(this).data('url'), 'projects-content', 'projects');
    return false;
});

$(document).on('click', '.new-project-link', function () {
    updatePanel($(this).data('url'), 'new-project', 'new-project');
    return false;
});

//************** CLIENTS TAB **************** //

$(document).on('click', '.clients-link', function () {
    updatePanel($(this).data('url'), 'client_data', 'clients');
    return false;
});

$(document).on('click', '.new-clients-link', function () {
    updatePanel($(this).data('url'), 'add_client_data', 'add_clients');
    return false;
});

$(document).on('click', '.show-client-link', function () {
    updatePanel($(this).data('url'), 'show_client', 'show_client');
    return false;
});
$(document).on('click', '.edit-client-link', function () {
    updatePanel($(this).data('url'), 'edit_client', 'edit_client');
    return false;
});

//************** FORMS TAB **************** //


$(document).on('click', '.forms-link', function () {
    updatePanel($(this).data('url'), 'forms-content', 'forms');
    return false;
});

$(document).on('click', '.new-form-link', function () {
    updatePanel($(this).data('url'), 'new-form', 'new-form');
    return false;
});

$(document).on('click', '.show-form-link', function () {
    updatePanel($(this).data('url'), 'show-form', 'show-form');
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

$(document).on('click', '#form_filter_btn', function() {
    var forms_table_items = $("#forms_list .form_item");
    forms_table_items.each(function() {
        var name_filter = $('#form_name_filter').val();
        var name = $(this).attr("value");
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


$(document).on({
    ajaxStart: function() {
        $(".loading-gif").css("visibility","visible");
    },
    ajaxStop: function() {
        $(".loading-gif").css("visibility","hidden");
    }
});





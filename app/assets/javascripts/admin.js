
function updatePanel(path, id_replace, tab) {
    $.get(path, function (response) {
        $('#' + id_replace).html(response);
        $('#myTab  a[href=#' + tab + ']').tab('show');
    }, 'html');
}

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


$('a[data-toggle="tab"]').on('shown', function (e) {
    e.target // activated tab
    e.relatedTarget // previous tab
})

$("#load-more").bind("ajax:complete", function (et, e) {
    $("#products-list").html(e.responseText); // insert content
});

$("#load-more").bind("ajax:loading", function (et, e) {
    $(this).html("Loading..."); // swap link text
});

function activate(me) {
    $('.active').each(function () {
        $(this).removeClass('active');
    });
    $(me).addClass('active');
}

$('#datepicker').datepicker();

function updatePanel(path, id_replace, tab) {
    $.get(path, function (response) {
        $('#' + id_replace).html(response);
        $('#myTab  a[href=#' + tab + ']').tab('show');

        //document.title = response.pageTitle;
        //window.history.replaceState({"html":response,"pageTitle":response.pageTitle,"id_replace":id_replace,"tab":tab});
    }, 'html');
}

function updatePanelMood(path, id_replace, tab) {
    $.get(path, function (response) {
        $('#' + id_replace).html(response);
        $('#face-list  a[href=#' + tab + ']').tab('show');

        //document.title = response.pageTitle;
        //window.history.replaceState({"html":response,"pageTitle":response.pageTitle,"id_replace":id_replace,"tab":tab});
    }, 'html');
}

window.onpopstate = function (e) {
    if (e.state) {
        $('#' + e.state.id_replace).html(e.state.html);
        $('#myTab  a[href=#' + e.state.tab + ']').tab('show');
        //document.getElementById("content").innerHTML = e.state.html;
        //document.title = e.state.pageTitle;
    }
};

$('.feedbacks-link').live('click', function () {
    updatePanel($(this).data('url'), 'feedbacks-table', 'feedbacks');
    return false;
});

$('.data-link').live('click', function () {
    updatePanel($(this).data('url'), 'data-content', 'project-data');
    return false;
});

$('#face-list').ready(function(){
    $('#msj-face-changed').fadeOut(0);
    $('#face-list li').click(function () {
        $('#msj-face-changed').fadeIn(300).fadeOut(1000);
    });
})






$('.change-mood1-link').live('click', function () {
    updatePanelMood($(this).data('url'), 'change-mood1-content', 'change-mood1');
    return false;
});

$('.change-mood3-link').live('click', function () {
    updatePanelMood($(this).data('url'), 'change-mood3-content', 'change-mood3');
    return false;
});

$('.change-mood5-link').live('click', function () {
    updatePanelMood($(this).data('url'), 'change-mood5-content', 'change-mood5');
    return false;
});

$('.change-mood7-link').live('click', function () {
    updatePanelMood($(this).data('url'), 'change-mood7-content', 'change-mood7');
    return false;
});

$('.change-mood9-link').live('click', function () {
    updatePanelMood($(this).data('url'), 'change-mood9-content', 'change-mood9');
    return false;
});

$('.new-feedback-link').live('click', function () {
    updatePanel($(this).data('url'), 'new-feedback-content', 'new-feedback');
    $('.new-feedback').removeClass('active');
    $('.feedbacks').addClass('active');
    return false;
});

$('.new-milestone-link').live('click', function () {
    updatePanel($(this).data('url'), 'new-milestone-content', 'new-milestone');
    return false;
});

$(".show-feedback-link").live('click', function () {
    updatePanel($(this).data('url'), 'show-feedback-content', 'show-feedback');
    return false;
});
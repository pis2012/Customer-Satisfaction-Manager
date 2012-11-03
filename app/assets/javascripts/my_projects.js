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

function updatePanel(path, el_replace, tab) {
    $.get(path, function (response) {
        $(el_replace).html(response);
        $('#myTab  a[href=#' + tab + ']').tab('show');
        //document.title = response.pageTitle;
        //window.history.replaceState({"html":response,"pageTitle":response.pageTitle,"id_replace":id_replace,"tab":tab});
    }, 'html');
}

/*window.onpopstate = function (e) {
    if (e.state) {
        $('#' + e.state.id_replace).html(e.state.html);
        $('#myTab  a[href=#' + e.state.tab + ']').tab('show');
        //document.getElementById("content").innerHTML = e.state.html;
        //document.title = e.state.pageTitle;
    }
};*/

$('#moodsTab').ready(function(){
    $('#msj-face-changed').fadeOut(0);
    $('#moodsTab li').click(function () {
        if (!$(this).hasClass("active")) {
            $('#msj-face-changed').fadeIn(300).fadeOut(1000);
        }
    });

    $('.estilotextarea').wysihtml5();
});

$('.change-mood-link').live('click', function () {
    if (!$(this).parent().hasClass("active")) {
        var mood = $(this).data('mood');
        $.get("my_projects/change_mood/" + mood, function (_) {
            $('#moodsTab  a[href=#mood' + mood + ']').tab('show');
        }, 'html');
    }
    return false;
});

$(document).on('click','.feedbacks-link', function () {
    updatePanel($(this).data('url'), '.feedbacks_table_wrapper', 'feedbacks');
    $('#edit-feedback-content').empty();
    $('#new-feedback-content').empty();
    return false;
});


$(document).on('click','.data-link', function () {
    updatePanel($(this).data('url'), '#data-content', 'project-data');
    return false;
});

$(document).on('click','.new-feedback-link', function () {
    updatePanel($(this).data('url'), '#new-feedback-content', 'new-feedback');
    return false;
});

$(document).on('show','#myTab a[href=#new-feedback]', function (e) {
    html_panel.panelInstance('feedback_content');
});

$(document).on('show','#myTab a[href=#edit-feedback]', function (e) {
    html_panel.panelInstance('feedback_content');

});

$(document).on('click','.new-milestone-link', function () {
    updatePanel($(this).data('url'), '#new-milestone-content', 'new-milestone');
    return false;
});

$(document).on('click','.show-feedback-link', function () {
    updatePanel($(this).data('url'), '#show-feedback', 'show-feedback');
    return false;
});

$(document).on('click','.edit-feedback-link', function () {
    updatePanel($(this).data('url'), '#edit-feedback-content', 'edit-feedback');
    return false;
});


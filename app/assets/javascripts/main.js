$(function() {
    $.ajaxSetup({ cache: true });

    if(Modernizr.history) {

        $.getScript(location.href);
        History.Adapter.bind(window,'statechange',function(){ // Note: We are using statechange instead of popstate
            if (window.loadRemoteScript) {
                $.getScript(location.href);
            }
            window.loadRemoteScript = true;
//            var State = History.getState(); // Note: We are using History.getState() instead of event.state
        });

//        $(window).bind('popstate', function(e) {
//            console.log('popstate: ' + location.href);
//            $.getScript(location.href);
//        });

    } else {
        // old browser
        var href = location.href;
        // remove first hash
        $.getScript(fixUrl(location.href));
        window.onhashchange = function(e) {
            $.getScript(fixUrl(location.href));
        }
    }

    function fixUrl(url) {
        return url.replace("/#", "/");
    }


    // Score modal
    $('.modal-view').on('click','.modal-close-btn', function() {
        $(this).closest('.modal-view').css({ visibility: 'hidden' });
    });

    footer();

});

function footer () {
    $('.footer').on('click', '#home_link', function() {
        $.getScript('/').done(function(script, textStatus) {
            if (textStatus == 'success') {
                window.loadRemoteScript = false;
                History.pushState({}, '', '/');
            }
        });
    });

    $('.footer').on('click', '#scores_link', function() {
        $.getScript('/scores').done(function(script, textStatus) {
            if (textStatus == 'success') {
                window.loadRemoteScript = false;
                History.pushState({}, '', '/scores');
            }
        });
    });
}

function changeMainView(content, notificationsCnt, notifications, pointsNotification) {
    $("#main-content").html(content);

    if (notificationsCnt > 0) {
        bootbox.alert(notifications);
    }

    if (typeof(pointsNotification) != 'undefined' && pointsNotification != null) {

    }
}

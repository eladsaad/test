$(function() {
    $.ajaxSetup({ cache: true });

//    $(document).ajaxStart(function () {
//        //show ajax indicator
//        console.log('loading data.. please wait..');
//    }).ajaxStop(function () {
//        //hide ajax indicator
//        console.log('finished..');
//    });

    $body = $('body');

    $(document).on({
        ajaxStart: function() { $body.addClass("loading");    },
        ajaxStop: function() { $body.removeClass("loading"); }
    });


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
    $('.footer').on('click', '.menuItem', function () {
        switchActive(this);
    });

    $('.footer').on('click', '#home_link, .programName', function() {
        $.getScript('/').done(function(script, textStatus) {
            if (textStatus == 'success') {
                window.loadRemoteScript = false;
                History.pushState({}, '', '/');
            }
        }).fail(function( jqxhr, settings, exception ) {
            bootbox.alert("Failed to load page");
        });
    });

    $('.footer').on('click', '#about_link', function() {
        $.getScript('/about').done(function(script, textStatus) {
            if (textStatus == 'success') {
                window.loadRemoteScript = false;
                History.pushState({}, '', '/about');
            }
        }).fail(function( jqxhr, settings, exception ) {
            bootbox.alert("Failed to load page");
        });
    });

    $('.footer').on('click', '#invite_link', function() {
        $.getScript('/invite').done(function(script, textStatus) {
            if (textStatus == 'success') {
                window.loadRemoteScript = false;
                History.pushState({}, '', '/invite');
            }
        }).fail(function( jqxhr, settings, exception ) {
            bootbox.alert("Failed to load page");
        });
    });

    $('.footer').on('click', '#scores_link', function() {
        $.getScript('/points_n_prizes').done(function(script, textStatus) {
            if (textStatus == 'success') {
                window.loadRemoteScript = false;
                History.pushState({}, '', '/points_n_prizes');
            }
        }).fail(function( jqxhr, settings, exception ) {
            bootbox.alert("Failed to load page");
        });
    });

    $('.points-view').click(function () {
        $.getScript('/points_n_prizes').done(function(script, textStatus) {
            if (textStatus == 'success') {
                window.loadRemoteScript = false;
                History.pushState({}, '', '/points_n_prizes');
            }
        }).fail(function( jqxhr, settings, exception ) {
            bootbox.alert("Failed to load page");
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

function switchActive(item) {
    $(item).siblings('.menuItem').removeClass('active');
    $(item).addClass('active');
}

// Helpers

function numberWithCommas(x) {
    var parts = x.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
}
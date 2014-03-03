$(function() {
    $.ajaxSetup({ cache: true });

    if(Modernizr.history) {

        $.getScript(location.href);
        History.Adapter.bind(window,'statechange',function(){ // Note: We are using statechange instead of popstate
            if (window.loadRemoteScript) {
                console.log('statechange: ' + location.href);
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
});

function changeMainView(content, notificationsCnt, notifications) {
    $("#main-content").html(content);
    //alert('"'+ notifications + '"');
    if (notificationsCnt > 0) {
        bootbox.alert(notifications);
    }
}

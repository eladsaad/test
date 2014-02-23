CINEMA_DRIVE = {
    common: {
        init: function() {
            // application-wide code
        }
    },

    static_pages: {
        init: function() {
            // controller-wide code
        },

        welcome: function() {
            // action-specific code

            // Login / Sign-up page
            if ($('#code-field').length) {
                showRegOptions();
                $('#code-field').on('keyup input change', showRegOptions);

                function showRegOptions() {
                    if ($('#code-field').val().length > 6) {
                        $('#reg-options').css('visibility', 'visible');
                        $('#reg-signin-form').css({'height': '220px', marginBottom: '0' });
                    } else {
                        $('#reg-options').css('visibility', 'hidden');
                        $('#reg-signin-form').css({'height': '190px', marginBottom: '30px' });
                    }
                }
            }

        }
    },

    interactive_videos: {
        index: function() {
            $('.banner').show();
            $('.points-view').show();
            $('.footer').show();
        }
    }
};

UTIL = {
    exec: function( controller, action ) {
        var ns = CINEMA_DRIVE,
            action = ( action === undefined ) ? "init" : action;

        if ( controller !== "" && ns[controller] && typeof ns[controller][action] == "function" ) {
            ns[controller][action]();
        }
    },

    init: function() {
        var body = document.body,
            controller = body.getAttribute( "data-controller" ),
            action = body.getAttribute( "data-action" );

        UTIL.exec( "common" );
        UTIL.exec( controller );
        UTIL.exec( controller, action );
    }
};

$( document ).ready( UTIL.init );



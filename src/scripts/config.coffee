require.config
    deps: [
        'main'
    ]
    paths:
        jquery: '../components/jquery/dist/jquery.min'
        pixi: '../components/pixi/bin/pixi'
        underscore: '../components/underscore/underscore'
        backbone: '../components/backbone/backbone'
        proton: '../components/proton/build/proton-1.0.0' 
        socketio: '../components/socket.io-client/socket.io' 
    shim:
        proton:
            exports: 'Proton'
        underscore:
            exports: '_'
        backbone:
            deps: [
                'jquery'
                'underscore'
            ]
            exports: 'Backbone'

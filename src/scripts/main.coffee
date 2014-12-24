define [
    'backbone'
    'underscore'
    'pixi'
    'socketio'
], (Backbone, _, PIXI, io ) ->
    console.log('main controller loaded')

    socket = io.connect("http://localhost")
    socket.on "midiinput", (msg) ->
        console.log msg 
    return

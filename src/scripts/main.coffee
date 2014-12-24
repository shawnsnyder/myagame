define [
    'backbone'
    'underscore'
    'pixi'
    'socketio'
    'modules/controller'
], (Backbone, _, PIXI, io, Controller ) ->
    
    console.log('in main') 
    controller = new Controller()
    return


define [
    'backbone'
    'underscore'
    'pixi'
    'socketio'
    'modules/fireball'
], (Backbone, _, PIXI, io, Fireball ) ->
    class controller    
        
        fbon: false
        constructor:()->
            @stage = new PIXI.Stage(0x000000, true);
            @fb= new Fireball(@stage) 
            width = document.body.clientWidth
            height = document.body.clientHeight
            renderoptions = 
                antialiasing:true
                transparent: false 
                resolution: 1
            @renderer = new PIXI.CanvasRenderer width, height, renderoptions
            document.body.appendChild(@renderer.view);
            console.log('main controller loaded')
            @socket = io.connect("http://localhost")
            @midirecieved = @midirecieved.bind @
            @update = @update.bind @
            @socket.on "midiinput", @midirecieved 
            requestAnimFrame(@update);
        midirecieved:  (msg)->
            console.log(msg)
            if msg[1] is 1
                @fb.proton.emitters[0].behaviours[3].panFoce.x = 2400
                
            else
                @fb.proton.emitters[0].behaviours[3].panFoce.x = 200
        update:  ->
            #convert to gsap tick 
            @renderer.render(@stage)
            @fb.beat() 
            requestAnimFrame(@update);
         
    
    controller 

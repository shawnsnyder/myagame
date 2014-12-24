
define [
    'pixi'
    'backbone'
    'proton'
], (PIXI, Backbone, Proton)->
    class fireball 
        constructor:(game_container)->
            _.extend(@, Backbone.Events) 
            @combgamemain_container = new PIXI.DisplayObjectContainer() 
            @combgamemain_container.x = 220 
            @combgamemain_container.y = 0 
            
            pt_minigames_container.addChild(@combgamemain_container)
            @combgame_container = new PIXI.DisplayObjectContainer() 
            
            @combgamemain_container.addChild(@combgame_container)
            

        start:()->
            @combgame_container.visible = false 
            @tl.reverse()
            @tl2.reverse()
    fireball 


   

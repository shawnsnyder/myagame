
define [
    'pixi'
    'backbone'
    'proton'
], (PIXI, Backbone, Proton)->
    class fireball 

        proton: new Proton()
        height: document.body.clientHeight
        width: document.body.clientWidth
        constructor:(game_container)->
            _.extend(@, Backbone.Events) 
            @fireball_container = new PIXI.DisplayObjectContainer() 
            game_container.addChild(@fireball_container)
            @createProton() 
            @createRender()
        start:()->
            @fireball_container.visible = true 
    
    
        createProton : (image) ->
            texture = new PIXI.Texture.fromImage("images/particle.png")
            emitter = new Proton.Emitter();
            emitter.damping = 0.0075;
            emitter.rate = new Proton.Rate(1440);
            emitter.addInitialize(new Proton.ImageTarget(texture, 32));
            emitter.addInitialize(new Proton.Position(new Proton.RectZone(0, 0, this.width, this.height)));
            emitter.addInitialize(new Proton.Mass(1), new Proton.Radius(Proton.getSpan(5, 10)));
            # repulsionBehaviour = new Proton.Repulsion(mouseObj, 0, 0);
            crossZoneBehaviour = new Proton.CrossZone(new Proton.RectZone(0, 0, this.width, this.height), 'cross');
            emitter.addBehaviour( crossZoneBehaviour);
            #emitter.addBehaviour(repulsionBehaviour, crossZoneBehaviour);
            emitter.addBehaviour(new Proton.Scale(Proton.getSpan(.1, .6)));
            emitter.addBehaviour(new Proton.Alpha(.5));
            emitter.addBehaviour(new Proton.RandomDrift(2, 2, .02));
            emitter.addBehaviour({
                initialize : (particle) ->
                    particle.tha = Math.random() * Math.PI;
                    particle.thaSpeed = 0.015 * Math.random() + 0.005;
                applyBehaviour : (particle) ->
                    particle.tha += particle.thaSpeed;
                    particle.alpha = Math.abs(Math.cos(particle.tha));
            });
            
            emitter.emit('once');
            @proton.addEmitter(emitter);
            return
    
        createRender : ->
            @renderer = new Proton.Renderer('other', @proton);
            
            @renderer.onProtonUpdate = ()->
            
            @renderer.onParticleCreated = (particle) =>

                particleSprite = new PIXI.Sprite(particle.target)
                particle.sprite = particleSprite
                @fireball_container.addChild particle.sprite
                return

            @renderer.onParticleUpdate = (particle) =>
                @transformSprite particle.sprite, particle
                return

            @renderer.onParticleDead = (particle) =>
                @fireball_container.removeChild particle.sprite
                return
               
            @renderer.start()
            return
        transformSprite:(particleSprite, particle) ->
            particleSprite.position.x = particle.p.x;
            particleSprite.position.y = particle.p.y;
            particleSprite.scale.x = particle.scale;
            particleSprite.scale.y = particle.scale;
            particleSprite.anchor.x = 0.5;
            particleSprite.anchor.y = 0.5;
            particleSprite.alpha = particle.alpha;
            #particleSprite.tint = '0x' + colorchange.rgbToHex( particle.transform.rgb.r, particle.transform.rgb.g, particle.transform.rgb.b)
            
            particleSprite.rotation = particle.rotation*Math.PI/180;
            return
        beat : ->
            @proton.update()
            return
    fireball 


   

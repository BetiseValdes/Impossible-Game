BgImage = require('./assets/bg.png')
Helicoptero = require('./assets/helicoptero.png')
stage = require('./elements/stage')
Jiro = require('./elements/Jiro')
Roca = require('./elements/Roca')
Lava = require('./elements/Lava')
DataLava = require('./data/paredes')
audio = require './assets/C.wav'
sound = require 'Howler'
mathjs = require 'mathjs'

class App extends PIXI.Application
  animation:true
  animationNodes:[]
  myStage: stage
  enemies: []
  paredes: []
  constructor:(w,h,o)->
    super(w,h,o)
    window.addEventListener 'keydown', @onKeyPress
    document.body.appendChild @view
    @preload()
    @bigImage()

  play:->
    console.log 'howl'
    sound = new sound.Howl(
      {
        src: ['images/C.wav']
        loop:true
        autoplay:true
      }
    )
    sound.play()
    null

  onKeyPress: (evt) =>
    if evt.key is 'a'
      return if @anim.x  < 15
      @anim.x -= 12

    if evt.key is 'd'
      return if @anim.x  > 585
      @anim.x += 12
        
  preload:=>
      PIXI.loader.add(BgImage).add(Helicoptero).load(@build)
    
  build:()=>
    Bg = new stage (BgImage)
    @stage.addChild Bg
    @heli = new stage (Helicoptero)
    @stage.addChild @heli
    @heli.x = 230
    @heli.scale.x = 0.5
    @heli.scale.y=-0.5
    @buildEnemy2()
    setTimeout =>
      @buildEnemy1()
    ,100
    @play()
    
    @anim = new Jiro(0, 0, 20, 20, '0x00ff00')
    @anim.x = 285
    @anim.y = 880
    @stage.addChild(@anim)
    #helicoptero = new
    @animate()

  buildEnemy2: =>
    @interval = setInterval =>
      @enemy = new Roca(25, 25, '0x4b3621', @)
      @stage.addChild(@enemy)
      @enemies.push(@enemy)
      @addAnimationNodes(@enemy)
    , 100

  bigImage:=>
    setTimeout =>
      clearInterval(@interval)
      @heli.scale.x = 0.5
      @heli.scale.y = 0.5
      @enemy.pausa = true
    ,30000

  buildEnemy1: =>
    for p in DataLava
      lava = new Lava(p, @)
      console.log lava.x
      @paredes.push(lava)
      l = @stage.children.length
      @stage.addChildAt(lava,l - 1)

  addAnimationNodes:(node)=>
    @animationNodes.push node

  collision:(anim, arr) =>
    for n in arr
      if (anim.x < n.x + n.width && anim.x + anim.width > n.x && anim.y < n.y + n.height && anim.height + anim.y > n.y)
        anim.alpha = 0
        #n.pause = true
        return true
    return false

  collisionBounds: (anim) =>
    if @anim.x > @view.width
      @anim.x = 0
    if @anim.x < 0
      @anim.x = @view.width

  animate:=>
    @ticker.add ()=>
      if @collision(@anim, @paredes)
        console.log 'chocó con lava'
        @anim.alpha = 0
        @paredes[0].alpha = 1
        @paredes[1].alpha = 1
      if @collision(@anim, @enemies)
        console.log 'chocó con enemigo'
      for n in @animationNodes
        n.animate?()

module.exports = App
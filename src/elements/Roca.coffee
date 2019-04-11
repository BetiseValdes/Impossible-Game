mathjs = require 'mathjs'

class Roca extends PIXI.Graphics
  pausa: false
  constructor: (w, h, color, app) ->
    super()
    @x = mathjs.randomInt(0, window.innerWidth)
    @y = 0
    @w = w
    @h = h
    @app = app
    @build()

  build:=>
    @beginFill(@color)
    @drawRect(0, 0, @w, @h)
    @endFill()

  collision:() ->

  animate: =>
    return if @pause
    @y += 9


module.exports = Roca
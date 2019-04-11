mathjs = require 'mathjs'

class Lava extends PIXI.Graphics

    constructor: (p, app) ->
      super()
      @app = app
      @data = p
      @beginFill(@data.color)
      @lineStyle(1, @data.color)
      @drawRect(0, 0, @data.w, @data.h)
      @x = @data.x
      @y = @data.y
      @endFill()
      @alpha = 0

    appear:() ->
      Lava.alpha = 1


module.exports = Lava
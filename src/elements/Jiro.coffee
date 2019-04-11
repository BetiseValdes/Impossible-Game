class Jiro extends PIXI.Graphics

    constructor: (x, y, w, h, color) ->
        super()
        @posX = x
        @posY = y
        @w = w
        @h = h
        @color = color
        @build()

    build:=>
        @beginFill(@color)
        @drawRect(@posX, @posY, @w, @h)
        @endFill()

module.exports = Jiro
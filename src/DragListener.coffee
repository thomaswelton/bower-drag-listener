define ['EventEmitter', 'mootools'], (EventEmitter) ->
	class DragListener extends EventEmitter
		constructor: (el) ->
			super()

			$(el).addEvents
				'mousedown' : @makeDragable
				'touchstart': @makeDragable

		getEvents: () =>
			events = 
				'mouseup' : @removeDragable
				'touchend' : @removeDragable
				'mousemove' : @pointerMove
				'touchmove' : @pointerMove

		makeDragable: (event) =>
			event.preventDefault()
			$(document.documentElement).addEvents @getEvents()

			@dragable = true

			@startPosition =
				x : event.client.x.toInt()
				y : event.client.y.toInt()

			@lastPosition = @startPosition

			@fireEvent 'dragstart'

		removeDragable: (event) =>
			@dragable = false
			$(document.documentElement).removeEvents @getEvents()

			@fireEvent 'dragend',
				x: @lastPosition.x - @startPosition.x
				y: @lastPosition.y - @startPosition.y

		pointerMove: (event) =>
			return if not @dragable
			
			currentX = event.client.x.toInt()
			currentY = event.client.y.toInt()

			@fireEvent 'dragmove',
				x : currentX - @lastPosition.x 
				y : currentY - @lastPosition.y

			## Update lastPosition for next calculation
			@lastPosition =
				x : currentX
				y : currentY

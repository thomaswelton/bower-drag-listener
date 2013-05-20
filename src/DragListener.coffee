define ['EventEmitter', 'mootools'], (EventEmitter) ->
	class DragListener extends EventEmitter
		constructor: (@el) ->
			super()

			@el.addEvents
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
			window.addEvents @getEvents()

			@dragable = true
			@delta =
				x : event.client.x.toInt()
				y : event.client.y.toInt()

			@fireEvent 'dragstart', @delta

		removeDragable: (event) =>
			@dragable = false
			window.removeEvents @getEvents()

			@fireEvent 'dragend', @delta

		pointerMove: (event) =>
			return if not @dragable
			
			deltaX = (@delta.x.toInt() - event.client.x.toInt())
			deltaY = (@delta.y.toInt() - event.client.y.toInt())

			@fireEvent 'dragmove', 
				x : deltaX
				y : deltaY

			## Reset delta for next calculation
			@delta =
				x : event.client.x.toInt()
				y : event.client.y.toInt()

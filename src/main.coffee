require ['DragListener', 'mootools', 'domReady!'], (DragListener) ->
	console.log 'DragListener main load'

	dragMe = document.getElementById 'dragMe'
	dragListener = new DragListener dragMe

	# In this demo top/left start at 0
	top = 0
	left = 0

	dragListener.addEvent 'dragmove', (delta) ->
		console.log delta
		# Use the deltas to get new values
		top += delta.y
		left += delta.x

		# Set the new values
		dragMe.style.top = "#{top}px"
		dragMe.style.left = "#{left}px"

	dragListener.addEvent 'dragend', (delta) ->
		console.log "Total delta for drag", delta
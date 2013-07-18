#requirejs-drag-listener

[![Build Status](https://travis-ci.org/thomaswelton/requirejs-drag-listener.png)](https://travis-ci.org/thomaswelton/requirejs-drag-listener)
[![Dependency Status](https://david-dm.org/thomaswelton/requirejs-drag-listener.png)](https://david-dm.org/thomaswelton/requirejs-drag-listener)

RequireJS AMD Module that listens for drag events on DOM elements.

## Events

- `dragstart` Fire when a user starts to drag an element
- `dragmove` Fired when a user moves an element. Returns a delta
- `dragend` Fired when a user finished dragging an element. Returns a delta

## Example usage

```js
define(['DragListener'], function(DragListener) {
	
	var element = document.getElementById
	var elementListener = new DragListener(element);
	
	elementListener.addEvent('dragstart', function() {
    	// Dragging has started
    });
	
	elementListener.addEvent('dragmove', function(delta) {
    	// The element has been dragged
    	// delta - the change in x/y since the last dragmove event
    });

    elementListener.addEvent('dragend', function(delta) {
    	// The dragging has finished
    	// delta - the change in x/y since dragstart
    });

});
```

(function() {
  require(['DragListener', 'mootools', 'domReady!'], function(DragListener) {
    var dragListener, dragMe, left, top;
    console.log('DragListener main load');
    dragMe = document.getElementById('dragMe');
    dragListener = new DragListener(dragMe);
    top = 0;
    left = 0;
    dragListener.addEvent('dragmove', function(delta) {
      console.log(delta);
      top += delta.y;
      left += delta.x;
      dragMe.style.top = "" + top + "px";
      return dragMe.style.left = "" + left + "px";
    });
    return dragListener.addEvent('dragend', function(delta) {
      return console.log("Total delta for drag", delta);
    });
  });

}).call(this);

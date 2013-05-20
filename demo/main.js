(function() {
  require(['DragListener', 'mootools', 'domReady!'], function(DragListener) {
    var dragListener, dragMe, left, top;

    console.log('DragListener main load');
    dragMe = document.getElementById('dragMe');
    dragListener = new DragListener(dragMe);
    top = 0;
    left = 0;
    console.log(top);
    return dragListener.addEvent('dragmove', function(delta) {
      top -= delta.y;
      left -= delta.x;
      dragMe.style.top = "" + top + "px";
      return dragMe.style.left = "" + left + "px";
    });
  });

}).call(this);

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['EventEmitter', 'mootools'], function(EventEmitter) {
    var DragListener;
    return DragListener = (function(_super) {
      __extends(DragListener, _super);

      function DragListener(el) {
        this.pointerMove = __bind(this.pointerMove, this);
        this.removeDragable = __bind(this.removeDragable, this);
        this.makeDragable = __bind(this.makeDragable, this);
        this.getEvents = __bind(this.getEvents, this);
        DragListener.__super__.constructor.call(this);
        $(el).addEvents({
          'mousedown': this.makeDragable,
          'touchstart': this.makeDragable
        });
      }

      DragListener.prototype.getEvents = function() {
        var events;
        return events = {
          'mouseup': this.removeDragable,
          'touchend': this.removeDragable,
          'mousemove': this.pointerMove,
          'touchmove': this.pointerMove
        };
      };

      DragListener.prototype.makeDragable = function(event) {
        event.preventDefault();
        $(document.documentElement).addEvents(this.getEvents());
        this.dragable = true;
        this.startPosition = {
          x: event.client.x.toInt(),
          y: event.client.y.toInt()
        };
        this.lastPosition = this.startPosition;
        return this.fireEvent('dragstart');
      };

      DragListener.prototype.removeDragable = function(event) {
        this.dragable = false;
        $(document.documentElement).removeEvents(this.getEvents());
        return this.fireEvent('dragend', {
          x: this.lastPosition.x - this.startPosition.x,
          y: this.lastPosition.y - this.startPosition.y
        });
      };

      DragListener.prototype.pointerMove = function(event) {
        var currentX, currentY;
        if (!this.dragable) {
          return;
        }
        currentX = event.client.x.toInt();
        currentY = event.client.y.toInt();
        this.fireEvent('dragmove', {
          x: currentX - this.lastPosition.x,
          y: currentY - this.lastPosition.y
        });
        return this.lastPosition = {
          x: currentX,
          y: currentY
        };
      };

      return DragListener;

    })(EventEmitter);
  });

}).call(this);

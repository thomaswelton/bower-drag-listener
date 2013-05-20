(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['EventEmitter', 'mootools'], function() {
    var DragListener;

    return DragListener = (function(_super) {
      __extends(DragListener, _super);

      function DragListener(el) {
        this.el = el;
        this.pointerMove = __bind(this.pointerMove, this);
        this.removeDragable = __bind(this.removeDragable, this);
        this.makeDragable = __bind(this.makeDragable, this);
        this.getEvents = __bind(this.getEvents, this);
        DragListener.__super__.constructor.call(this);
        this.el.addEvents({
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
        $(document.body).addEvents(this.getEvents());
        this.dragable = true;
        this.delta = {
          x: event.client.x.toInt(),
          y: event.client.y.toInt()
        };
        return this.fireEvent('dragstart', this.delta);
      };

      DragListener.prototype.removeDragable = function(event) {
        this.dragable = false;
        $(document.body).removeEvents(this.getEvents());
        return this.fireEvent('dragend', this.delta);
      };

      DragListener.prototype.pointerMove = function(event) {
        var deltaX, deltaY;

        if (!this.dragable) {
          return;
        }
        deltaX = this.delta.x.toInt() - event.client.x.toInt();
        deltaY = this.delta.y.toInt() - event.client.y.toInt();
        this.fireEvent('dragmove', {
          x: deltaX,
          y: deltaY
        });
        return this.delta = {
          x: event.client.x.toInt(),
          y: event.client.y.toInt()
        };
      };

      return DragListener;

    })(EventEmitter);
  });

}).call(this);

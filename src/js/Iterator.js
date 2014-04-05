(function() {
  var Iterator;

  Iterator = (function() {
    function Iterator(length, interval) {
      this.length = length != null ? length : 0;
      this.interval = interval != null ? interval : 1;
      this.index = 0;
    }

    Iterator.prototype.setInterval = function(interval) {
      this.interval = interval;
    };

    Iterator.prototype.add = function(num) {
      if (num == null) {
        num = 1;
      }
      return this.index += num * this.interval;
    };

    Iterator.prototype.minus = function(num) {
      if (num == null) {
        num = 1;
      }
      return this.index -= num * this.interval;
    };

    Iterator.prototype.getIndex = function() {
      return this.index;
    };

    Iterator.prototype.getNum = function() {
      return this.index + 1;
    };

    Iterator.prototype.getNextIndex = function() {
      return this.index + this.interval;
    };

    Iterator.prototype.getPreIndex = function() {
      return this.index - this.interval;
    };

    Iterator.prototype.getLenth = function() {
      return this.length;
    };

    Iterator.prototype.reset = function() {
      return this.index = 0;
    };

    Iterator.prototype.isEnd = function() {
      return this.getNum() >= this.length;
    };

    return Iterator;

  })();

  if (typeof module !== "undefined" && module !== null ? module.exports : void 0) {
    module.exports = Iterator;
  } else {
    if (this.J == null) {
      this.J = {};
    }
    this.J.Iterator = Iterator;
  }

}).call(this);

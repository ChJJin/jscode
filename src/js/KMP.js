(function() {
  var Iterator, KMP, getMatchTable, getPrefixs, getSuffixs;

  getMatchTable = function(str) {
    var i, j, matchTable, prefixs, subStr, suffixs, _i, _j, _ref;
    matchTable = [];
    for (i = _i = 0, _ref = str.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
      matchTable[i] = 0;
      subStr = str.slice(0, i + 1);
      prefixs = getPrefixs(subStr);
      suffixs = getSuffixs(subStr);
      for (j = _j = 0; 0 <= i ? _j < i : _j > i; j = 0 <= i ? ++_j : --_j) {
        if (prefixs[j] === suffixs[i - 1 - j]) {
          matchTable[i] = j + 1;
        }
      }
    }
    return matchTable;
  };

  getPrefixs = function(str) {
    var i, prefixs, _i, _ref;
    prefixs = [];
    for (i = _i = 1, _ref = str.length; 1 <= _ref ? _i < _ref : _i > _ref; i = 1 <= _ref ? ++_i : --_i) {
      prefixs.push(str.slice(0, i));
    }
    return prefixs;
  };

  getSuffixs = function(str) {
    var i, suffixs, _i, _ref;
    suffixs = [];
    for (i = _i = 1, _ref = str.length; 1 <= _ref ? _i < _ref : _i > _ref; i = 1 <= _ref ? ++_i : --_i) {
      suffixs.push(str.slice(i));
    }
    return suffixs;
  };

  Iterator = (typeof module !== "undefined" && module !== null ? module.exports : void 0) ? require('./Iterator') : this.J.Iterator;

  KMP = function(search) {
    var matchString, matchTable, sl;
    if (search == null) {
      search = "";
    }
    matchTable = getMatchTable(search);
    sl = search.length;
    return matchString = function(str) {
      var i, matchNum, matchValue, searchIterator, _i, _ref;
      matchNum = 0;
      searchIterator = new Iterator(sl);
      for (i = _i = 0, _ref = str.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        if (str[i] === search[searchIterator.getIndex()]) {
          if (searchIterator.isEnd()) {
            return i - searchIterator.getIndex();
          }
          searchIterator.add();
          matchNum++;
        } else {
          matchValue = matchTable[searchIterator.getPreIndex()];
          searchIterator.minus(matchNum - matchValue);
          i--;
        }
      }
    };
  };

  if (typeof module !== "undefined" && module !== null ? module.exports : void 0) {
    module.exports = KMP;
  } else {
    if (this.J == null) {
      this.J = {};
    }
    this.J.KMP = KMP;
  }

}).call(this);

(function() {
  var J, argsClass, arrayClass, boolClass, dateClass, hasOwnProperty, numberClass, objectClass, regexpClass, stringClass, toString,
    __slice = [].slice;

  J = {};

  argsClass = '[object Arguments]';

  arrayClass = '[object Array]';

  boolClass = '[object Boolean]';

  dateClass = '[object Date]';

  numberClass = '[object Number]';

  objectClass = '[object Object]';

  regexpClass = '[object RegExp]';

  stringClass = '[object String]';

  toString = Object.prototype.toString;

  hasOwnProperty = Object.prototype.hasOwnProperty;

  J.has = function(obj, key) {
    var has;
    return has = hasOwnProperty.call(obj, key);
  };

  J.isNumber = function(value) {
    var isNumber;
    return isNumber = (typeof value === 'number') || (toString.call(value) === numberClass);
  };

  J.isString = function(value) {
    var isString;
    return isString = (typeof value === 'string') || (toString.call(value) === stringClass);
  };

  J.isBoolean = function(value) {
    var isBoolean;
    return isBoolean = (value === false) || (value === true) || (toString.call(value) === boolClass);
  };

  J.isDate = function(obj) {
    var isDate;
    return isDate = toString.call(obj) === dateClass;
  };

  J.isRegExp = function(obj) {
    var isRegExp;
    return isRegExp = toString.call(obj) === regexpClass;
  };

  J.isArguments = function(obj) {
    var isArguments;
    return isArguments = (typeof obj === 'object') && (toString.call(obj) === argsClass);
  };

  J.isFunction = function(obj) {
    var isFunction;
    return isFunction = typeof obj === 'function';
  };

  J.isArray = Array.isArray || function(obj) {
    var isArray;
    return isArray = obj && (typeof obj === 'object') && (typeof obj.length === 'number') && (toString.call(obj) === arrayClass);
  };

  J.isObject = function(obj) {
    var isObject;
    return isObject = obj && (typeof obj === 'object') || (typeof obj === 'function');
  };

  J.isPlainObject = function(obj) {
    var isPlainObject;
    return isPlainObject = toString.call(obj) === objectClass;
  };

  J.isEmpty = function(value) {
    var key;
    if (!value) {
      return true;
    }
    if (J.isArray(value) || J.isString(value) || J.isArguments(value)) {
      return value.length === 0;
    }
    for (key in value) {
      if (J.has(value, key)) {
        return false;
      }
    }
    return true;
  };

  J.pick = function(data, key, defaultValue) {
    var k, parts, _i, _len;
    if (key == null) {
      key = '';
    }
    if (!J.isObject(data)) {
      return defaultValue;
    }
    parts = key.split(/(?:\[(\d+)\]\.?)|\./g);
    for (_i = 0, _len = parts.length; _i < _len; _i++) {
      k = parts[_i];
      if (!((k != null) && (k !== ""))) {
        continue;
      }
      data = data[k];
      if (data == null) {
        return defaultValue;
      }
    }
    return data;
  };

  J.extend = function() {
    var deep, dest, key, source, src, value, _i, _j, _len;
    dest = arguments[0], src = 3 <= arguments.length ? __slice.call(arguments, 1, _i = arguments.length - 1) : (_i = 1, []), deep = arguments[_i++];
    if (!J.isBoolean(deep)) {
      dest = arguments[0], src = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      deep = true;
    }
    for (_j = 0, _len = src.length; _j < _len; _j++) {
      source = src[_j];
      for (key in source) {
        value = source[key];
        if (J.has(source, key)) {
          if (deep) {
            if (dest[key] == null) {
              dest[key] = {};
            }
            if (J.isArray(value) && J.isEmpty(dest[key])) {
              dest[key] = [];
            }
            if (J.isObject(value)) {
              J.extend(dest[key], value, deep);
            } else {
              dest[key] = value;
            }
          } else {
            dest[key] = value;
          }
        }
      }
    }
    return dest;
  };

  J.join = function(obj, divider, prefix) {
    var deepRet, key, ret, value;
    if (divider == null) {
      divider = '.';
    }
    if (prefix == null) {
      prefix = '';
    }
    ret = {};
    if (J.isArray(obj)) {
      ret = [];
    }
    for (key in obj) {
      value = obj[key];
      if (J.has(obj, key)) {
        if (J.isObject(value)) {
          deepRet = J.join(value, divider, "" + prefix + key + divider);
          ret = J.extend(ret, deepRet, true);
        } else {
          ret["" + prefix + key] = value;
        }
      }
    }
    return ret;
  };

  if (typeof module !== "undefined" && module !== null ? module.exports : void 0) {
    module.exports = J;
  } else {
    if (this.J == null) {
      this.J = {};
    }
    this.J._ = J;
  }

}).call(this);

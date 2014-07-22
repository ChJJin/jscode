(function() {
  var decode, encode;

  encode = function(input) {
    var code, i, output, _i, _ref;
    input = input.replace(/\r\n/g, '\n');
    output = "";
    for (i = _i = 0, _ref = input.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
      code = input.charCodeAt(i);
      if (code < 0x0080) {
        output += String.fromCharCode(code);
      } else if ((code > 0x0079) && (code < 0x0800)) {
        output += "%" + ((code >> 6) | 192).toString(16).toUpperCase();
        output += "%" + ((code & 63) | 128).toString(16).toUpperCase();
      } else if ((code > 0x07FF) && (code < 0x10000)) {
        output += "%" + ((code >> 12) | 224).toString(16).toUpperCase();
        output += "%" + (((code >> 6) & 63) | 128).toString(16).toUpperCase();
        output += "%" + ((code & 63) | 128).toString(16).toUpperCase();
      } else {
        output += "%" + ((code >> 18) | 240).toString(16).toUpperCase();
        output += "%" + (((code >> 12) & 63) | 128).toString(16).toUpperCase();
        output += "%" + (((code >> 6) & 63) | 128).toString(16).toUpperCase();
        output += "%" + ((code & 63) | 128).toString(16).toUpperCase();
      }
    }
    return output;
  };

  decode = function(input) {
    var charcode, code, i, j, output, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2;
    output = "";
    i = 0;
    while (i < input.length) {
      code = [];
      if (input.charAt(i) === "%") {
        code[0] = parseInt(input.slice(i + 1, i + 3), 16);
        i += 3;
      } else {
        code[0] = input.charCodeAt(i++);
      }
      charcode = 0;
      if (code[0] < 128) {
        charcode = code[0];
      } else if ((code[0] > 0xBF) && (code[0] < 0xE0)) {
        _ref = [1];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          j = _ref[_i];
          code[j] = parseInt(input.slice(i + 1, i + 3), 16);
          i += 3;
        }
        charcode = ((code[0] & 31) << 6) | (code[1] & 63);
      } else if ((code[0] > 0xDF) && (code[0] < 0xF0)) {
        _ref1 = [1, 2];
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          j = _ref1[_j];
          code[j] = parseInt(input.slice(i + 1, i + 3), 16);
          i += 3;
        }
        charcode = ((code[0] & 15) << 12) | ((code[1] & 63) << 6) | (code[2] & 63);
      } else {
        _ref2 = [1, 2, 3];
        for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
          j = _ref2[_k];
          code[j] = parseInt(input.slice(i + 1, i + 3), 16);
          i += 3;
        }
        charcode = ((code[0] & 7) << 18) | ((code[1] & 63) << 12) | ((code[2] & 63) << 6) | (code[3] & 63);
      }
      output += String.fromCharCode(charcode);
    }
    return output;
  };

  if (typeof module !== "undefined" && module !== null ? module.exports : void 0) {
    module.exports = {
      encode: encode,
      decode: decode
    };
  } else {
    if (this.J == null) {
      this.J = {};
    }
    this.J.utf8 = {
      encode: encode,
      decode: decode
    };
  }

}).call(this);

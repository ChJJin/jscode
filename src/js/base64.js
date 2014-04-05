(function() {
  var base64hash, decode, encode, handleDecodeOutput, handleEncodeInput;

  base64hash = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';

  encode = function(input) {
    var chr1, chr2, chr3, code, i, iuput, j, output, _ref;
    iuput = handleEncodeInput(input);
    output = "";
    i = 0;
    while (i < input.length) {
      _ref = (function() {
        var _i, _results;
        _results = [];
        for (j = _i = 0; _i < 3; j = ++_i) {
          _results.push(input.charCodeAt(i++));
        }
        return _results;
      })(), chr1 = _ref[0], chr2 = _ref[1], chr3 = _ref[2];
      code = [];
      code[0] = chr1 >> 2;
      code[1] = ((chr1 & 3) << 4) | (chr2 >> 4);
      code[2] = ((chr2 & 15) << 2) | (chr3 >> 6);
      code[3] = chr3 & 63;
      if (isNaN(chr2)) {
        code[2] = code[3] = 64;
      } else if (isNaN(chr3)) {
        code[3] = 64;
      }
      output += ((function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = code.length; _i < _len; _i++) {
          j = code[_i];
          _results.push(base64hash.charAt(j));
        }
        return _results;
      })()).join("");
    }
    return output;
  };

  decode = function(input) {
    var chr, code, i, j, output;
    input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
    output = "";
    i = 0;
    while (i < input.length) {
      code = (function() {
        var _i, _results;
        _results = [];
        for (j = _i = 0; _i < 4; j = ++_i) {
          _results.push(base64hash.indexOf(input.charAt(i++)));
        }
        return _results;
      })();
      chr = [];
      chr[0] = (code[0] << 2) | (code[1] >> 4);
      chr[1] = ((code[1] & 15) << 4) | (code[2] >> 2);
      chr[2] = ((code[2] & 3) << 6) | code[3];
      if (code[3] === 64) {
        chr.length = 2;
      }
      if (code[2] === 64) {
        chr.length = 1;
      }
      output += ((function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = chr.length; _i < _len; _i++) {
          j = chr[_i];
          _results.push(String.fromCharCode(j));
        }
        return _results;
      })()).join("");
    }
    return output = handleDecodeOutput(output);
  };

  handleEncodeInput = function(input) {
    if (/([^\u0000-\u00ff])/.test(input)) {
      throw new Error('invalid char');
    }
    return input;
  };

  handleDecodeOutput = function(output) {
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
    this.J.Base64 = {
      encode: encode,
      decode: decode
    };
  }

}).call(this);

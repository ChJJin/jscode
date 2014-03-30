(function() {
  var decode, encode;

  encode = function(input) {
    var code, i, output, _i, _ref;
    input = input.replace(/\r\n/g, '\n');
    output = "";
    for (i = _i = 0, _ref = input.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
      code = input.charCodeAt(i);
      if (code < 128) {
        output += String.fromCharCode(code);
      } else if ((code > 127) && (code < 2048)) {
        output += String.fromCharCode((code >> 6) | 192);
        output += String.fromCharCode((code & 63) | 128);
      } else if ((code > 2047) && (code < 65536)) {
        output += String.fromCharCode((code >> 12) | 224);
        output += String.fromCharCode(((code >> 6) & 63) | 128);
        output += String.fromCharCode((code & 63) | 128);
      } else {
        output += String.fromCharCode((code >> 18) | 240);
        output += String.fromCharCode(((code >> 12) & 63) | 128);
        output += String.fromCharCode(((code >> 6) & 63) | 128);
        output += String.fromCharCode((code & 63) | 128);
      }
    }
    return output;
  };

  decode = function(input) {
    var charcode, code, code2, code3, code4, i, output;
    output = "";
    i = 0;
    while (i < input.length) {
      code = input.charCodeAt(i++);
      charcode = 0;
      if (code < 128) {
        charcode = String.fromCharCode(code);
      } else if ((code > 191) && (code < 224)) {
        code2 = input.charCodeAt(i++);
        charcode = ((code & 31) << 6) | (code2 & 63);
      } else if ((code > 223) && (code < 240)) {
        code2 = input.charCodeAt(i++);
        code3 = input.charCodeAt(i++);
        charcode = ((code & 15) << 12) | ((code2 & 63) << 6) | (code3 & 63);
      } else {
        code2 = input.charCodeAt(i++);
        code3 = input.charCodeAt(i++);
        code4 = input.charCodeAt(i++);
        charcode = ((code & 7) << 18) | ((code2 & 63) << 12) | ((code3 & 63) << 6) | (code4 & 63);
      }
      output += String.fromCharCode(charcode);
    }
    return output;
  };

  this.utf8 = {
    encode: encode,
    decode: decode
  };

}).call(this);

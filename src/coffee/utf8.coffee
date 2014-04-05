# /*
#  * utf8
#  * @author JJin
#  *
#  *    Unicode符号范围  |  UTF-8编码方式
#  *       (十六进制)    |   （二进制）
#  * --------------------+----------------------------------------
#  * 0000 0000-0000 007F | 0xxxxxxx
#  * 0000 0080-0000 07FF | 110xxxxx 10xxxxxx
#  * 0000 0800-0000 FFFF | 1110xxxx 10xxxxxx 10xxxxxx
#  * 0001 0000-0010 FFFF | 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
#  *
#  */

encode = (input)->
  input = input.replace /\r\n/g, '\n'
  output = ""

  for i in [0...input.length]
    code = input.charCodeAt i

    if code < 128
      # 0000 0000-0000 007F -> 0xxxxxxx
      output += String.fromCharCode code
    else if (code > 127) and (code < 2048)
      # 0000 0080-0000 07FF -> 110xxxxx 10xxxxxx
      output += String.fromCharCode((code >> 6) | 192)
      output += String.fromCharCode((code & 63) | 128)
    else if (code > 2047) and (code < 65536)
      # 0000 0800-0000 FFFF -> 1110xxxx 10xxxxxx 10xxxxxx
      output += String.fromCharCode((code >> 12) | 224)
      output += String.fromCharCode(((code >> 6) & 63) | 128)
      output += String.fromCharCode((code & 63) | 128)
    else
      # 0001 0000-0010 FFFF -> 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
      output += String.fromCharCode((code >> 18) | 240)
      output += String.fromCharCode(((code >> 12) & 63) | 128)
      output += String.fromCharCode(((code >> 6) & 63) | 128)
      output += String.fromCharCode((code & 63) | 128)

  output

decode = (input)->
  output = ""

  i = 0
  while i < input.length
    code = input.charCodeAt i++
    charcode = 0
    if code < 128
      # 0xxxxxxx
      charcode = String.fromCharCode code
    else if (code > 191) and (code < 224)
      # 110xxxxx 10xxxxxx
      code2 = input.charCodeAt i++
      charcode = ((code & 31) << 6) | (code2 & 63)
    else if (code > 223) and (code < 240)
      # 1110xxxx 10xxxxxx 10xxxxxx
      code2 = input.charCodeAt i++
      code3 = input.charCodeAt i++
      charcode = ((code & 15) << 12) | ((code2 & 63) << 6) | (code3 & 63)
    else
      # 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
      code2 = input.charCodeAt i++
      code3 = input.charCodeAt i++
      code4 = input.charCodeAt i++
      charcode = ((code & 7) << 18) | ((code2 & 63) << 12) | ((code3 & 63) << 6) | (code4 & 63)

    output += String.fromCharCode charcode

  output

if module?.exports
  module.exports = {encode, decode}
else
  @J ?= {}
  @J.utf8 = {encode, decode}

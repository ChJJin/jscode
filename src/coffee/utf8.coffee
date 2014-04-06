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

    if code < 0x0080
      # 0000 0000-0000 007F -> 0xxxxxxx
      output += String.fromCharCode code
    else if (code > 0x0079) and (code < 0x0800)
      # 0000 0080-0000 07FF -> 110xxxxx 10xxxxxx
      output += "%" + ((code >> 6) | 192).toString(16).toUpperCase()
      output += "%" + ((code & 63) | 128).toString(16).toUpperCase()
    else if (code > 0x07FF) and (code < 0x10000)
      # 0000 0800-0000 FFFF -> 1110xxxx 10xxxxxx 10xxxxxx
      output += "%" + ((code >> 12) | 224).toString(16).toUpperCase()
      output += "%" + (((code >> 6) & 63) | 128).toString(16).toUpperCase()
      output += "%" + ((code & 63) | 128).toString(16).toUpperCase()
    else
      # 0001 0000-0010 FFFF -> 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
      output += "%" + ((code >> 18) | 240).toString(16).toUpperCase()
      output += "%" + (((code >> 12) & 63) | 128).toString(16).toUpperCase()
      output += "%" + (((code >> 6) & 63) | 128).toString(16).toUpperCase()
      output += "%" + ((code & 63) | 128).toString(16).toUpperCase()

  output

decode = (input)->
  output = ""

  i = 0
  while i < input.length
    code = []
    if input.charAt(i) is "%"
      code[0] = parseInt input.slice(i+1, i+3), 16
      i += 3
    else
      code[0] = input.charCodeAt i++

    charcode = 0
    if code[0] < 128
      # 0xxxxxxx
      charcode = code[0]
    else if (code[0] > 0xBF) and (code[0] < 0xE0)
      # 110xxxxx 10xxxxxx
      for j in [1]
        code[j] = parseInt input.slice(i+1, i+3), 16
        i += 3
      charcode = ((code[0] & 31) << 6) | (code[1] & 63)
    else if (code[0] > 0xDF) and (code[0] < 0xF0)
      # 1110xxxx 10xxxxxx 10xxxxxx
      for j in [1, 2]
        code[j] = parseInt input.slice(i+1, i+3), 16
        i += 3
      charcode = ((code[0] & 15) << 12) | ((code[1] & 63) << 6) | (code[2] & 63)
    else
      # 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
      for j in [1, 2, 3]
        code[j] = parseInt input.slice(i+1, i+3), 16
        i += 3
      charcode = ((code[0] & 7) << 18) | ((code[1] & 63) << 12) | ((code[2] & 63) << 6) | (code[3] & 63)

    output += String.fromCharCode charcode

  output

if module?.exports
  module.exports = {encode, decode}
else
  @J ?= {}
  @J.utf8 = {encode, decode}

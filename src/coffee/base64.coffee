# /*
#  * base64 算法
#  * @author JJin
#  *
#  * base64 编码：
#  *   1. 按字符串长度，每3个8bit为1组；
#  *   2. 针对每组，获取每个字符的ASCII编码，得到 3*8 个字节；
#  *   3. 把24个字节分成 4*6，高位补0，得到4个8bit；
#  *   4. 把4个8bit转换为十进制(1-63)；
#  *   5. 按照base64编码表，转换为对应字符；
#  *   6. 如果长度不为3的倍数，则用0代替，然后转换为字符"="；
#  */

base64hash = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='

encode = (input)->
  iuput = handleEncodeInput input
  output = ""

  i = 0
  while i < input.length
    [chr1, chr2, chr3] = (input.charCodeAt i++ for j in [0...3])

    code = []

    code[0] = chr1 >> 2
    code[1] = ((chr1 &  3) << 4) | (chr2 >> 4)
    code[2] = ((chr2 & 15) << 2) | (chr3 >> 6)
    code[3] = chr3 & 63

    if isNaN chr2
      code[2] = code[3] = 64
    else if isNaN chr3
      code[3] = 64

    output += (base64hash.charAt j for j in code).join ""

  output

decode = (input)->
  input = input.replace /[^A-Za-z0-9\+\/\=]/g, ""
  output = ""

  i = 0
  while i < input.length
    code = (base64hash.indexOf input.charAt i++ for j in [0...4])

    chr = []

    chr[0] = (code[0] << 2) | (code[1] >> 4)
    chr[1] = ((code[1] & 15) << 4) | (code[2] >> 2)
    chr[2] = ((code[2] &  3) << 6) | code[3]

    if code[3] is 64 then chr.length = 2
    if code[2] is 64 then chr.length = 1

    output += (String.fromCharCode j for j in chr).join ""

  output = handleDecodeOutput output

handleEncodeInput = (input)->
  if /([^\u0000-\u00ff])/.test input
    throw new Error 'invalid char'
  input

handleDecodeOutput = (output)->
  output

if module?.exports
  module.exports = {encode, decode}
else
  @J ?= {}
  @J.Base64 = {encode, decode}

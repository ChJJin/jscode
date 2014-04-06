chai = require 'chai'
should = chai.should()
utf8 = require '../src/coffee/utf8.coffee'

chai.config.includeStack = true

describe 'utf8', ()->
  describe 'encode', ()->
    it 'should encode chars from `\\u0000` to `\\u007F` correctly', ()->
      test_str = ['\u0000', '\u0023', '\u0058', '\u007F']
      for str in test_str
        utf8.encode(str).should.equal(str)

    it 'should encode chars from `\\u0080` to `\\u07FF` correctly', ()->
      test_str = ['\u0080', '\u0093', '\u00B6', '\u05DC', '\u07FF']
      for str in test_str
        utf8.encode(str).should.equal(encodeURI str)

    it 'should encode chars from `\\u0800` to `\\uFFFF` correctly', ()->
      test_str = ['\u0800', '\u0A96', '\u2528', '\u5361', '\uC8B6', '\uFFFF']
      for str in test_str
        utf8.encode(str).should.equal(encodeURI str)

    it 'should encode chars correctly', ()->
      test_str = ['你好啊哈哈哈', '你ab我', '&*…&吧', 'helloworld']
      for str in test_str
        utf8.encode(str).should.equal(encodeURI str)

  describe 'decode', ()->
    it 'should decode chars from `\\u0000` to `\\u007F` correctly', ()->
      test_str = ['\u0000', '\u0023', '\u0058', '\u007F']
      for str in test_str
        utf8.decode(str).should.equal(str)

    it 'should decode chars from `\\u0080` to `\\u07FF` correctly', ()->
      test_str = ['\u0080', '\u0093', '\u00B6', '\u05DC', '\u07FF']
      test_str[i] = encodeURI(str) for str, i in test_str
      for str in test_str
        utf8.decode(str).should.equal(decodeURI str)

    it 'should decode chars from `\\u0800` to `\\uFFFF` correctly', ()->
      test_str = ['\u0800', '\u0A96', '\u2528', '\u5361', '\uC8B6', '\uFFFF']
      test_str[i] = encodeURI(str) for str, i in test_str
      for str in test_str
        utf8.decode(str).should.equal(decodeURI str)

    it 'should decode chars correctly', ()->
      test_str = ['你好啊哈哈哈', '你ab我', '&*…&吧', 'hello world']
      test_str[i] = encodeURI(str) for str, i in test_str
      for str in test_str
        utf8.decode(str).should.equal(decodeURI str)

chai = require 'chai'
should = chai.should()
KMP = require '../src/coffee/KMP.coffee'

chai.config.includeStack = true

describe 'KMP', ()->
  it 'should match string', ()->
    tests = [
      str: '23kjxs3kb'
      search: '3k'
    ,
      str: '3ldkccc'
      search: 'ccd'
    ,
      str: 'accdcdcddccdc'
      search: 'dccd'
    ,
      str: 'bbc abcdab abcdabcdabde'
      search: 'abcdabd'
    ]
    for test in tests
      str = test.str
      search = test.search
      KMP(search)(str).should.equal(str.indexOf search)


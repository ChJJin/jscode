chai = require 'chai'
should = chai.should()
base64 = require '../src/coffee/base64.coffee'

chai.config.includeStack = true

describe 'base64', ()->
  describe 'encode', ()->
    it 'should encode 3n chars correctly', ()->
      base64.encode('abc').should.equal('YWJj')
      base64.encode('kjeidx').should.equal('a2plaWR4')

    it 'should encode 3n+1 chars correctly', ()->
      base64.encode('xndl').should.equal('eG5kbA==')
      base64.encode('ocex').should.equal('b2NleA==')

    it 'should encode 3n+2 chars correctly', ()->
      base64.encode('x9.xl').should.equal('eDkueGw=')
      base64.encode('mc04-').should.equal('bWMwNC0=')

  describe 'decode', ()->
    it 'should decode 3n chars correctly', ()->
      base64.decode('enl4').should.equal('zyx')
      base64.decode('LmRr').should.equal('.dk')

    it 'should decode 3n+1 chars correctly', ()->
      base64.decode('MG14ZQ==').should.equal('0mxe')
      base64.decode('dixmMw==').should.equal('v,f3')

    it 'should decode 3n+2 chars correctly', ()->
      base64.decode('ZWZhZGY=').should.equal('efadf')
      base64.decode('OTg9Zms=').should.equal('98=fk')

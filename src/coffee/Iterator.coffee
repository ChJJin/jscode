class Iterator
  constructor: (@length = 0, @interval = 1)-> @index = 0

  setInterval: (@interval)->

  add: (num = 1)-> @index += num * @interval

  minus: (num = 1)-> @index -= num * @interval

  getIndex: ()-> @index

  getNum: ()-> @index + 1

  getNextIndex: ()-> @index + @interval

  getPreIndex: ()-> @index - @interval

  getLenth: ()-> @length

  reset: ()-> @index = 0

  isEnd: ()-> @getNum() >= @length

if module?.exports
  module.exports = Iterator
else
  @J ?= {}
  @J.Iterator = Iterator

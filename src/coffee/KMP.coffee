getMatchTable = (str)->
  matchTable = []
  for i in [0...str.length]
    matchTable[i] = 0
    subStr = str.slice 0, i+1
    prefixs = getPrefixs subStr
    suffixs = getSuffixs subStr
    for j in [0...i] when prefixs[j] is suffixs[i-1-j]
      matchTable[i] = j+1
  matchTable

# /*
#  * get the an array of prefixs of giving string
#  *
#  * @example
#  *
#  * getPrefixs("abcd")
#  * // => ["a", "ab", "abc"]
#  */
getPrefixs = (str)->
  prefixs = []
  for i in [1...str.length]
    prefixs.push str.slice 0, i
  prefixs

# /*
#  * get the an array of suffixs of giving string
#  *
#  * @example
#  *
#  * getSuffixs("abcd")
#  * // => ["bcd", "cd", "d"]
#  */
getSuffixs = (str)->
  suffixs = []
  for i in [1...str.length]
    suffixs.push str.slice i
  suffixs

Iterator = if module?.exports then require('./Iterator') else @J.Iterator

KMP = (search = "")->
  matchTable = getMatchTable search
  sl = search.length
  matchString = (str)->
    matchNum = 0
    searchIterator = new Iterator sl
    for i in [0...str.length]
      if str[i] is search[searchIterator.getIndex()]
        if searchIterator.isEnd()
          return i - searchIterator.getIndex()
        searchIterator.add()
        matchNum++
      else
        matchValue = matchTable[searchIterator.getPreIndex()]
        searchIterator.minus(matchNum - matchValue)
        i--

if module?.exports
  module.exports = KMP
else
  @J ?= {}
  @J.KMP = KMP

J = {}

argsClass   = '[object Arguments]'
arrayClass  = '[object Array]'
boolClass   = '[object Boolean]'
dateClass   = '[object Date]'
numberClass = '[object Number]'
objectClass = '[object Object]'
regexpClass = '[object RegExp]'
stringClass = '[object String]'

toString = Object.prototype.toString
hasOwnProperty = Object.prototype.hasOwnProperty

# /*
#  * Checks if the specified `key` exists as a
#  * direct property of `obj`, instead of an
#  * inherited property.
#  */
J.has = (obj, key)->
  has = hasOwnProperty.call(obj, key)

# /*
#  * check if `value` is a number
#  * note: 'NaN' is considered a number
#  */
J.isNumber = (value)->
  isNumber = (typeof value is 'number') or (toString.call(value) is numberClass)

# /*
#  * check if `value` is a string
#  */
J.isString = (value)->
  isString = (typeof value is 'string') or (toString.call(value) is stringClass)

# /*
#  * check if `value` is a boolean value
#  */
J.isBoolean = (value)->
  isBoolean = (value is false) or
      (value is true) or
      (toString.call(value) is boolClass)

# /*
#  * check if `value` is a date
#  * note: typeof date is a object
#  */
J.isDate = (obj)->
  isDate = toString.call(obj) is dateClass

# /*
#  * check if `value` is a regular expression
#  * note: typeof regexp is a object
#  */
J.isRegExp = (obj)->
  isRegExp = toString.call(obj) is regexpClass

# /*
#  * check if `value` is a `arguments` object
#  */
J.isArguments = (obj)->
  isArguments = (typeof obj is 'object') and (toString.call(obj) is argsClass)

# /*
#  * check if `value` is a `function` object
#  */
J.isFunction = (obj)->
  isFunction = typeof obj is 'function'

# /*
#  * check if `value` is a `array` object
#  */
J.isArray = Array.isArray || (obj)->
  isArray = obj and
      (typeof obj is 'object') and
      (typeof obj.length is 'number') and
      (toString.call(obj) is arrayClass)

# /*
#  * check if `value` is a object
#  * (e.g. arrays, functions, objects, regexes, `new Number(0)`, and `new String('')`)
#  */
J.isObject = (obj)->
  isObject = obj and (typeof obj is 'object') or (typeof obj is 'function')

# /*
#  * check if `value` is a plain object
#  * note: return true only if `value` is object like `{}`
#  */
J.isPlainObject = (obj)->
  isPlainObject = toString.call(obj) is objectClass

# /*
#  * check if `value` is empty
#  * note: if arrays, strings, arguments with length of `0`,
#  *       or objects without own keys, are considered `empty`
#  */
J.isEmpty = (value)->
  if not value then return true
  if J.isArray(value) or J.isString(value) or J.isArguments(value) then return value.length is 0
  for key of value when J.has(value, key) then return false
  return true

# /*
#  * get the specified `key` of `data`
#  * note: `key` can be specified like `a.b[0].c`
#  *       then return the value of data.a.b[0].c
#  */
J.pick = (data, key = '', defaultValue)->
  if not J.isObject(data) then return defaultValue

  parts = key.split /(?:\[(\d+)\]\.?)|\./g
  for k in parts when k? and (k isnt "")
    data = data[k]
    if not data?
      return defaultValue

  return data

# /*
#  * merge source data to destination by turns.
#  * if `deep` is false (default `true`), then the
#  * value on the first layer from the source data
#  * will directly overwrite the destination data.
#  *
#  * @example
#  *
#  * J.extend({a: {b: 1, c: 2}}, {a: {b: 3}}, false);
#  * // => {a: {b: 3}}
#  *
#  * J.extend({a: {b: 1, c: 2}}, {a: {b: 3}}, true);
#  * // => {a: {b: 3, c: 2}}
#  */
J.extend = (dest, src..., deep)->
  if not J.isBoolean(deep)
    [dest, src...] = arguments
    deep = true
  for source in src
    for key, value of source when J.has source, key
      if deep
        if not dest[key]? then dest[key] = {}
        if J.isArray(value) and J.isEmpty(dest[key]) then dest[key] = []

        if J.isObject value
          J.extend dest[key], value, deep
        else
          dest[key] = value
      else
        dest[key] = value
  return dest

# /*
#  * join key with divider of obj.
#  *
#  * @example
#  *
#  * J.join({a: {b: 1, c: 2}});
#  * // => {'a.b': 1, 'a.c': 2}
#  */
J.join = (obj, divider = '.', prefix = '')->
  ret = {}
  if J.isArray(obj) then ret = []
  for key, value of obj when J.has obj, key
    if J.isObject(value)
      deepRet = J.join value, divider, "#{prefix}#{key}#{divider}"
      ret = J.extend ret, deepRet, true
    else
      ret["#{prefix}#{key}"] = value
  return ret

if module?.exports
  module.exports = J
else
  @J ?= {}
  @J._ = J

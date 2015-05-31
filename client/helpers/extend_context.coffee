# http://stackoverflow.com/questions/28015971/pass-parameters-to-template-without-overriding-data-context?lq=1

Template.registerHelper 'extendContext', (key, value) ->
  result = _.clone this
  result[key] = value
  return result

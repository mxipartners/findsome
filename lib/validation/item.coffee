@validateItem = (item) ->
  check item, Match.ObjectIncluding
    title: String
    description: Match.Optional(String)
  errors = {}
  if item.title == ''
    errors.title = TAPi18n.__ "Please provide a title"
  return errors

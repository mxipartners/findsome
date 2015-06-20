@validateItem = (item) ->
  errors = {}
  if not item.title
    errors.title = TAPi18n.__ "Please provide a title"
  return errors

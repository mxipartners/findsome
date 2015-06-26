To validate items we check that they have a title.

    @validateItem = (item) ->
      errors = {}
      if not item.title
        errors.title = TAPi18n.__ "Please provide a title"
      return errors

To **validate items** we check that they have a `title` and an optional
`description`.

Items can both be containers like projects and checklists, as well as
singular items such as sources, findings, and risks.

    @validateItem = (item) ->

First, check that the item has the right structure.

      check item, Match.ObjectIncluding
        title: String
        description: Match.Optional(String)

Then, check that a title is present.

      errors = {}
      if item.title == ''
        errors.title = TAPi18n.__ "Please provide a title"
      return errors

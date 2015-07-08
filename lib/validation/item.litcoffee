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
        if Meteor.isServer

When running on the server, a missing title is a fatal error.

          throw new Meteor.Error('invalid-item', 'You must add a title to an item')
        else

When running on the client, we will tell the user to provide a title.

          errors.title = TAPi18n.__ "Please provide a title"
      return errors

**Project items** are items that belong to a project. To validate them, we
check they have a `projectId`, and that the project the id refers to actually
exists.

    @validateProjectItem = (item) ->

First, check that it has the right structure.

      check item, Match.ObjectIncluding
        projectId: String

Then, check that the project exists. A missing project is always an error since
the project id is provided by the client-side software and not the user.

      project = Projects.findOne item.projectId
      if not project
        throw new Meteor.Error('invalid-project-item',
          'You must provide a valid project id for the project item')

Finally, check that the project item is a valid item.

      validateItem item

**Checklist items** are items that belong to a checklist. To validate them, we
check they have a `checklistId`, and that the checklist the id refers to
actually exists.

    @validateChecklistItem = (item) ->

First, check that it has the right structure.

      check item, Match.ObjectIncluding
        checklistId: String

Then, check that the checklist exists. A missing checklist is always an error
since the checklist id is provided by the client-side software and not the user.

      checklist = Checklists.findOne item.checklistId
      if not checklist
        throw new Meteor.Error('invalid-checklist-item',
          'You must provide a valid checklist id for the checklist item')

Finally, check that the checklist item is a valid item.

      validateItem item

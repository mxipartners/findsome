Template.projectItem.events
  'click .edit-project': (e) ->
    e.preventDefault()
    Session.set 'itemEdited', this._id

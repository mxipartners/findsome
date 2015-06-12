Template.projectItem.events
  'click .edit-project': (e) ->
    e.preventDefault()
    start_editing(this)

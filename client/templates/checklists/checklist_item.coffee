Template.checklistItem.events
  'click .edit-checklist': (e) ->
    e.preventDefault()
    start_editing(this)

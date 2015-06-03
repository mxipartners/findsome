Template.item.events
  'click .edit': (e) ->
    e.preventDefault()
    Session.set 'itemEdited', this

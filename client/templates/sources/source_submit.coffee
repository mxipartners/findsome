Template.sourceSubmit.helpers
  has_sources: -> Sources.find().count() > 0

Template.sourceSubmit.events
  'submit form': (e, template) ->
    e.preventDefault()

    $title = $(e.target).find '[name=title]'
    $description = $(e.target).find '[name=description]'
    source =
      title: $title.val()
      description: $description.val()
      projectId: template.data._id

    Session.set 'source_title', {}
    errors = validateSource source
    if errors.title
      Session.set 'source_title', errors
      return false

    Meteor.call 'sourceInsert', source, (error, sourceId) ->
      if error
        throwError error.reason
      else
        $title.val('')
        $description.val('')

  'click .cancel': (e) -> stop_submitting()

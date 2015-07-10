Template.criteriumSubmit.helpers
  has_criteria: -> Criteria.find().count() > 0

Template.criteriumSubmit.events
  'submit form': (e, template) ->
    e.preventDefault()

    $title = $(e.target).find '[name=title]'
    $description = $(e.target).find '[name=description]'
    criterium =
      title: $title.val()
      description: $description.val()
      checklistId: template.data._id

    Session.set 'criterium_title', {}
    errors = validateCriterium criterium
    if errors.title
      Session.set 'criterium_title', errors
      return false

    Meteor.call 'criteriumInsert', criterium, (error, criteriumId) ->
      if error
        throwError error.reason
      else
        $title.val('')
        $description.val('')

  'click .cancel': (e) -> stop_submitting()

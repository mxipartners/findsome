Template.measureSubmit.onCreated -> Session.set 'measureSubmitErrors', {}

Template.measureSubmit.onRendered ->
  $(".risk-select").select2
    placeholder: TAPi18n.__ "Select risks"

Template.measureSubmit.helpers
  errorMessage: (field) -> Session.get('measureSubmitErrors')[field]
  errorClass: (field) ->
    if Session.get('measureSubmitErrors')[field] then 'has-error' else ''
  risks: -> Risks.find()
  has_measures: -> Measures.find().count() > 0

Template.measureSubmit.events
  'submit form': (e, template) ->
    e.preventDefault()

    $title = $(e.target).find '[name=title]'
    $description = $(e.target).find '[name=description]'
    $risks = $(e.target).find '[name=risks]'
    measure =
      title: $title.val()
      description: $description.val()
      risks: $risks.val() or []
      projectId: template.data._id

    Session.set 'measureSubmitErrors', {}
    Session.set 'measure_title', {}
    errors = validateMeasure measure
    if errors.title
      Session.set 'measure_title', errors
    if errors.risks
      Session.set 'measureSubmitErrors', errors
    if errors.title or errors.risks
      return false;

    Meteor.call 'measureInsert', measure, (error, measureId) ->
      if error
        throwError error.reason
      else
        $title.val('')
        $description.val('')

  'click .cancel': (e) -> stop_submitting()

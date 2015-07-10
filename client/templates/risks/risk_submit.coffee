Template.riskSubmit.onCreated ->
  Session.set 'riskSubmitErrors', {}

Template.riskSubmit.onRendered ->
  $(".finding-select").select2
    placeholder: TAPi18n.__ "Select findings"

Template.riskSubmit.helpers
  errorMessage: (field) -> Session.get('riskSubmitErrors')[field]
  errorClass: (field) ->
    if Session.get('riskSubmitErrors')[field] then 'has-error' else ''
  findings: -> Findings.find()
  has_risks: -> Risks.find().count() > 0

Template.riskSubmit.events
  'submit form': (e, template) ->
    e.preventDefault()

    $title = $(e.target).find '[name=title]'
    $description = $(e.target).find '[name=description]'
    $findings = $(e.target).find '[name=findings]'
    risk =
      title: $title.val()
      description: $description.val()
      findings: $findings.val() or []
      projectId: template.data._id

    Session.set 'riskSubmitErrors', {}
    Session.set 'risk_title', {}
    errors = validateRisk risk
    if errors.title
      Session.set 'risk_title', errors
    if errors.findings
      Session.set 'riskSubmitErrors', errors
    if errors.title or errors.findings
      return false

    Meteor.call 'riskInsert', risk, (error, riskId) ->
      if error
        throwError error.reason
      else
        $title.val('')
        $description.val('')

  'click .cancel': (e) -> stop_submitting()

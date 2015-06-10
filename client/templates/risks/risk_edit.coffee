Template.riskEdit.onCreated -> Session.set 'riskEditErrors', {}

Template.riskEdit.onRendered ->
  $(".finding-select").select2
    placeholder: TAPi18n.__ "Select findings"

Template.riskEdit.helpers
  errorMessage: (field) -> Session.get('riskEditErrors')[field]
  errorClass: (field) ->
    if !!Session.get('riskEditErrors')[field] then 'has-error' else ''
  findings: -> Findings.find()
  findingIsSelected: ->
    risk = Template.parentData()
    this._id in risk.findings
  hasNoMeasures: ->
    Measures.find({risks: this._id}).count() == 0

Template.riskEdit.events
  'submit form': (e, template) ->
    e.preventDefault()

    $title = $(e.target).find '[name=title]'
    $description = $(e.target).find '[name=description]'
    $findings = $(e.target).find '[name=findings]'
    riskProperties =
      title: $title.val()
      description: $description.val()
      findings: $findings.val()

    Session.set 'risk_title', {}
    Session.set 'riskEditErrors', {}
    errors = validateRisk riskProperties
    if errors.title
      Session.set 'risk_title', errors
    if errors.findings
      Session.set 'riskEditErrors', errors
    if errors.title or errors.findings
      return false

    Risks.update this._id, {$set: riskProperties}, (error) ->
      if error
        throwError error.reason
      else
        stop_editing()

  'click .cancel': (e) -> stop_editing()


Template.deleteRisk.helpers
  translated_kind: -> TAPi18n.__ this.kind


Template.deleteRisk.events
  'click .delete': (e) ->
    Risks.remove this._id
    # Make sure the backdrop is hidden before we go to the project page.
    $('#deleteRisk').on('hidden.bs.modal', stop_editing).modal('hide')

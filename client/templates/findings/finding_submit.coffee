Template.findingSubmit.onCreated ->
  Session.set 'findingSubmitErrors', {}


Template.findingSubmit.onRendered ->
  this.$(".source-select").select2
    placeholder: TAPi18n.__ "Select sources"


Template.findingSubmit.helpers
  errorMessage: (field) -> Session.get('findingSubmitErrors')[field]
  errorClass: (field) ->
    if Session.get('findingSubmitErrors')[field] then 'has-error' else ''
  sources: -> Sources.find()
  has_findings: -> Findings.find().count() > 0


Template.findingSubmit.events
  'submit form': (e, template) ->
    e.preventDefault()

    $title = $(e.target).find '[name=title]'
    $description = $(e.target).find '[name=description]'
    $sources = $(e.target).find '[name=sources]'
    $criteria = $(e.target).find '[name=criteria]'
    finding =
      title: $title.val()
      description: $description.val()
      sources: $sources.val() or []
      criteria: $criteria.val() or []
      projectId: template.data._id

    Session.set 'findingSubmitErrors', {}
    Session.set 'finding_title', {}
    errors = validateFinding finding
    if errors.title
      Session.set 'finding_title', errors
    if errors.sources
      Session.set 'findingSubmitErrors', errors
    if errors.title or errors.sources
      return false

    Meteor.call 'findingInsert', finding, (error, findingId) ->
      if error
        throwError error.reason
      else
        $title.val('')
        $description.val('')

  'click .cancel': (e) -> stop_submitting()


Template.criteriaSelect.helpers
  project_criteria: ->
    Criteria.find {checklistId: {$in: this.checklists or []}}


Template.criteriaSelect.onRendered ->
  this.$(".criterium-select").select2
    placeholder: TAPi18n.__ "Select criteria"

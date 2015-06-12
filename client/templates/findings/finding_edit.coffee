Template.findingEdit.onCreated ->
  Session.set 'findingEditErrors', {}

Template.findingEdit.onRendered ->
  $(".source-select").select2
    placeholder: TAPi18n.__ "Select sources"

Template.findingEdit.helpers
  errorMessage: (field) -> Session.get('findingEditErrors')[field]
  errorClass: (field) ->
    if Session.get('findingEditErrors')[field] then 'has-error' else ''
  sources: -> Sources.find()
  sourceIsSelected: ->
    finding = Template.parentData()
    this._id in finding.sources
  hasNoRisks: -> Risks.find({findings: this._id}).count() == 0

Template.findingEdit.events
  'submit form': (e, template) ->
    e.preventDefault()

    $title = $(e.target).find '[name=title]'
    $description = $(e.target).find '[name=description]'
    $sources = $(e.target).find '[name=sources]'
    findingProperties =
      title: $title.val()
      description: $description.val()
      sources: $sources.val()

    Session.set 'finding_title', {}
    Session.set 'findingEditErrors', {}
    errors = validateFinding findingProperties
    if errors.title
      Session.set 'finding_title', errors
    if errors.sources
      Session.set 'findingEditErrors', errors
    if errors.title or errors.sources
      return false

    Findings.update this._id, {$set: findingProperties}, (error) ->
      if error
        throwError error.reason
      else
        stop_editing()

  'click .cancel': (e) -> stop_editing()


Template.deleteFinding.helpers
  translated_kind: -> TAPi18n.__ this.kind


Template.deleteFinding.events
  'click .delete': (e) ->
    delete_finding = =>
      Findings.remove this._id
      stop_editing()
    # Make sure the backdrop is hidden before we do anything.
    $('#deleteFinding').modal('hide').on('hidden.bs.modal', delete_finding)
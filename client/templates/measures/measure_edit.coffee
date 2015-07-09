Template.measureEdit.onCreated -> Session.set 'measureEditErrors', {}

Template.measureEdit.onRendered ->
  this.$(".risk-select").select2
    placeholder: TAPi18n.__ "Select risks"

Template.measureEdit.helpers
  errorMessage: (field) -> Session.get('measureEditErrors')[field]
  errorClass: (field) ->
    if Session.get('measureEditErrors')[field] then 'has-error' else ''
  risks: -> Risks.find()
  riskIsSelected: ->
    measure = Template.parentData()
    this._id in measure.risks

Template.measureEdit.events
  'submit form': (e, template) ->
    e.preventDefault()

    $title = $(e.target).find '[name=title]'
    $description = $(e.target).find '[name=description]'
    $risks = $(e.target).find '[name=risks]'
    measureProperties =
      title: $title.val()
      description: $description.val()
      risks: $risks.val() or []

    Session.set 'measure_title', {}
    Session.set 'measureEditErrors', {}
    errors = validateMeasure measureProperties
    if errors.title
      Session.set 'measure_title', errors
    if errors.risks
      Session.set 'measureEditErrors', errors
    if errors.title or errors.risks
      return false

    Measures.update this._id, {$set: measureProperties}, (error) ->
      if error
        throwError error.reason
      else
        stop_editing()

  'click .cancel': (e) -> stop_editing()


Template.deleteMeasure.helpers
  translated_kind: -> TAPi18n.__ this.kind


Template.deleteMeasure.events
  'click .delete': (e) ->
    delete_measure = =>
      Measures.remove this._id
      stop_editing()
    # Make sure the backdrop is hidden before we do anything.
    $('#deleteMeasure').modal('hide').on('hidden.bs.modal', delete_measure)

Template.criteriumEdit.helpers
  hasNoFindings: ->
    Findings.find({criteria: this._id}).count() == 0


Template.criteriumEdit.events
  'submit form': (e, template) ->
    e.preventDefault()

    $title = $(e.target).find '[name=title]'
    $description = $(e.target).find '[name=description]'
    criteriumProperties =
      title: $title.val()
      description: $description.val()

    Session.set 'criterium_title', {}
    errors = validateCriterium criteriumProperties
    if errors.title
      Session.set 'criterium_title', errors
      return false

    Criteria.update this._id, {$set: criteriumProperties}, (error) ->
      if error
        throwError error.reason
      else
        stop_editing()

  'click .cancel': (e) -> stop_editing()


Template.deleteCriterium.helpers
  translated_kind: -> TAPi18n.__ this.kind


Template.deleteCriterium.events
  'click .delete': (e) ->
    delete_criterium = =>
      Criteria.remove this._id
      stop_editing()
    # Make sure the backdrop is hidden before we do anything.
    $('#deleteCriterium').modal('hide').on('hidden.bs.modal', delete_criterium)

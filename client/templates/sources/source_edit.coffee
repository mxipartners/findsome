go_to_project = (projectId) ->
  Session.set 'itemEdited', null
  Router.go 'projectPage', _id: projectId


Template.sourceEdit.helpers
  hasNoFindings: ->
    Findings.find({sources: this._id}).count() == 0


Template.sourceEdit.events
  'submit form': (e, template) ->
    e.preventDefault()

    $title = $(e.target).find '[name=title]'
    $description = $(e.target).find '[name=description]'
    sourceProperties =
      title: $title.val()
      description: $description.val()

    Session.set 'source_title', {}
    errors = validateSource sourceProperties
    if errors.title
      Session.set 'source_title', errors
      return false

    Sources.update this._id, {$set: sourceProperties}, (error) ->
      if error
        throwError error.reason
      else
        go_to_project this.projectId

  'click .cancel': (e) -> go_to_project this.projectId


Template.deleteSource.helpers
  translated_kind: -> TAPi18n.__ this.kind


Template.deleteSource.events
  'click .delete': (e) ->
    Sources.remove this._id
    # Make sure the backdrop is hidden before we go to the project page.
    $('#deleteSource').on('hidden.bs.modal', ->
      go_to_project this.projectId
    ).modal('hide')

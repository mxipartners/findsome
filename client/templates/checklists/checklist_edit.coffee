Template.checklistEdit.onCreated ->
  Session.set 'checklistEditErrors', {}

Template.checklistEdit.onRendered ->
  $(".owner-select").select2
    placeholder: TAPi18n.__ "Select checklist owners"

Template.checklistEdit.helpers
  usernames: -> Meteor.users.find {}, {sort: {username: 1}}
  userIsOwner: ->
    checklist = Template.parentData()
    this._id in checklist.owners
  errorMessage: (field) ->
    Session.get('checklistEditErrors')[field]
  errorClass: (field) ->
    if Session.get('checklistEditErrors')[field] then 'has-error' else ''

Template.checklistEdit.events
  'submit form': (e) ->
    e.preventDefault()

    checklistProperties =
      title: $(e.target).find('[name=title]').val()
      description: $(e.target).find('[name=description]').val()
      owners: $(e.target).find('[name=owners]').val() or []

    Session.set 'checklist_title', {}
    Session.set 'checklistEditErrors', {}
    errors = validateChecklist checklistProperties

    if errors.title
      Session.set 'checklist_title', errors
    if errors.owners
      Session.set 'checklistEditErrors', errors
    if errors.title or errors.owners
      return false

    Checklists.update this._id, {$set: checklistProperties}, (error) ->
      if error
        throwError error.reason
      else
        stop_editing()

  'click .cancel': (e) -> stop_editing()


Template.deleteChecklist.helpers
  translated_kind: -> TAPi18n.__ this.kind


Template.deleteChecklist.events
  'click .delete': (e) ->
    remove_checklist = =>
      Checklists.remove this._id
      Router.go 'home'
    # Make sure the backdrop is hidden before we do anything.
    $('#deleteChecklist').modal('hide').on('hidden.bs.modal', remove_checklist)

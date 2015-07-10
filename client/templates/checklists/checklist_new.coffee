Template.checklistNew.onCreated ->
  Session.set 'checklistNewErrors', {}


Template.checklistNew.onRendered ->
  $(".owner-select").select2
    placeholder: TAPi18n.__ "Select checklist owners"


Template.checklistNew.helpers
  usernames: -> Meteor.users.find()
  userIsCurrentUser: -> this._id == Meteor.userId()
  errorMessage: (field) -> Session.get('checklistNewErrors')[field]
  errorClass: (field) ->
    if Session.get('checklistNewErrors')[field] then 'has-error' else ''


Template.checklistNew.events
  'submit form': (e) ->
    e.preventDefault()

    checklist =
      title: $(e.target).find('[name=title]').val()
      description: $(e.target).find('[name=description]').val()
      owners: $(e.target).find('[name=owners]').val() or []

    Session.set 'checklist_title', {}
    Session.set 'checklistNewErrors', {}
    errors = validateChecklist checklist
    if errors.title
      Session.set 'checklist_title', errors
    if errors.owners
      Session.set 'checklistNewErrors', errors
    if errors.title or errors.owners
      return false

    Meteor.call 'checklistInsert', checklist, (error, result) ->
      if error
        throwError error.reason
      else
        Router.go 'checklistPage', {_id: result._id}

  'click .cancel': (e) -> stop_submitting()

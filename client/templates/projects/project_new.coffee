Template.projectNew.onCreated ->
  Session.set 'projectNewErrors', {}


Template.projectNew.onRendered ->
  $(".member-select").select2
    placeholder: TAPi18n.__ "Select project members"
  $(".checklist-select").select2
    placeholder: TAPi18n.__ "Select checklists"


Template.projectNew.helpers
  usernames: -> Meteor.users.find {}, {sort: {username: 1}}
  checklists: -> Checklists.find {}, {sort: {title: 1}}
  userIsCurrentUser: -> this._id == Meteor.userId()
  errorMessage: (field) -> Session.get('projectNewErrors')[field]
  errorClass: (field) ->
    if Session.get('projectNewErrors')[field] then 'has-error' else ''


Template.projectNew.events
  'submit form': (e) ->
    e.preventDefault()

    project =
      title: $(e.target).find('[name=title]').val()
      description: $(e.target).find('[name=description]').val()
      members: $(e.target).find('[name=members]').val() or []
      checklists: $(e.target).find('[name=checklists]').val() or []

    Session.set 'project_title', {}
    Session.set 'projectNewErrors', {}
    errors = validateProject project
    if errors.title
      Session.set 'project_title', errors
    if errors.members
      Session.set 'projectNewErrors', errors
    if errors.title or errors.members
      return false

    Meteor.call 'projectInsert', project, (error, result) ->
      if error
        throwError error.reason
      else
        stop_submitting()
        Router.go 'projectPage', {_id: result._id}

  'click .cancel': (e) -> stop_submitting()

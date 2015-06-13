Template.projectEdit.onCreated ->
  Session.set 'projectEditErrors', {}

Template.projectEdit.onRendered ->
  $(".member-select").select2
    placeholder: TAPi18n.__ "Select project members"

Template.projectEdit.helpers
  usernames: -> Meteor.users.find()
  userIsMember: ->
    project = Template.parentData()
    this._id in project.members
  errorMessage: (field) ->
    Session.get('projectEditErrors')[field]
  errorClass: (field) ->
    if Session.get('projectEditErrors')[field] then 'has-error' else ''

Template.projectEdit.events
  'submit form': (e) ->
    e.preventDefault()

    projectProperties =
      title: $(e.target).find('[name=title]').val()
      description: $(e.target).find('[name=description]').val()
      members: $(e.target).find('[name=members]').val()

    Session.set 'project_title', {}
    Session.set 'projectEditErrors', {}
    errors = validateProject projectProperties

    if errors.title
      Session.set 'project_title', errors
    if errors.members
      Session.set 'projectEditErrors', errors
    if errors.title or errors.members
      return false

    Projects.update this._id, {$set: projectProperties}, (error) ->
      if error
        throwError error.reason
      else
        stop_editing()

  'click .cancel': (e) -> stop_editing()


Template.deleteProject.helpers
  translated_kind: -> TAPi18n.__ this.kind


Template.deleteProject.events
  'click .delete': (e) ->
    remove_project = =>
      Projects.remove this._id
      Router.go 'projectsList'
    # Make sure the backdrop is hidden before we do anything.
    $('#deleteProject').modal('hide').on('hidden.bs.modal', remove_project)

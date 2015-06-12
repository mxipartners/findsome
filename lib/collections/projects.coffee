@Projects = new Mongo.Collection 'projects'

Projects.allow
  update: (userId, project) -> isProjectMember userId, project
  remove: (userId, project) -> isProjectMember userId, project

Projects.deny
  update: (userId, project, fieldNames) ->
    # may only edit the following fields:
    _.without(fieldNames, 'title', 'description', 'members').length > 0

Projects.deny
  update: (userId, project, fieldNames, modifier) ->
      if modifier.$set == undefined
        return ""
      errors = validateProject modifier.$set
      errors.title or errors.members

@validateProject = (project) ->
  errors = {}
  if not project.title
    errors.title = TAPi18n.__ "Please provide a title"
  if not project.members
    errors.members = TAPi18n.__ "Please select at least one project member"
  return errors

Meteor.methods
  projectInsert: (projectAttributes) ->
    check Meteor.userId(), String
    check projectAttributes,
      title: String
      description: String
      members: Array
    errors = validateProject projectAttributes
    if errors.title
      throw new Meteor.Error('invalid-project', "You must set a title for your project")
    if errors.members
      throw new Meteor.Error('invalid-project', "You must select as least one project member")
    user = Meteor.user()
    project = _.extend projectAttributes,
      userId: user._id
      author: user.username
      submitted: new Date()
      kind: 'project'
    projectId = Projects.insert project
    text = user.username + ' added you as project member to ' + project.title
    createNotification(member, user._id, projectId, text) for member in project.members
    return {_id: projectId}

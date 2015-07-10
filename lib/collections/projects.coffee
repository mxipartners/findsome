@Projects = new Mongo.Collection 'projects'

Projects.allow
  update: (userId, project) -> isProjectMember userId, project
  remove: (userId, project) -> isProjectMember userId, project

Projects.deny
  update: (userId, project, fieldNames) ->
    # may only edit the following fields:
    _.without(fieldNames, 'title', 'description', 'members', 'checklists').length > 0

Projects.deny
  update: (userId, project, fieldNames, modifier) ->
      if modifier.$set == undefined
        return ""
      errors = validateProject modifier.$set
      errors.title or errors.members

Meteor.methods
  projectInsert: (projectAttributes) ->
    check Meteor.userId(), String
    validateProject projectAttributes
    user = Meteor.user()
    project = _.extend projectAttributes,
      userId: user._id
      submitted: new Date()
      kind: 'project'
    projectId = Projects.insert project
    text = user.username + ' added you as project member to ' + project.title
    createNotification(member, user._id, projectId, text) for member in project.members
    return {_id: projectId}

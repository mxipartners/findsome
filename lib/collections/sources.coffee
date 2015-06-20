@Sources = new Mongo.Collection 'sources'

Sources.allow
  update: (userId, source) -> ownsProjectItem userId, source
  remove: (userId, source) -> ownsProjectItem userId, source

Sources.deny
  remove: (userId, source) -> Findings.find({sources: source._id}).count() > 0

Meteor.methods
  sourceInsert: (sourceAttributes) ->
    check this.userId, String
    check sourceAttributes,
      projectId: String
      title: String
      description: String
    user = Meteor.user();
    project = Projects.findOne sourceAttributes.projectId
    if not project
      throw new Meteor.Error('invalid-source', 'You must add a source to a project')
    source = _.extend sourceAttributes,
      userId: user._id
      submitted: new Date()
      position: Sources.find({projectId: sourceAttributes.projectId}).count()
      kind: 'source'
    # Create the source, save the id
    source._id = Sources.insert source
    # Now create a notification, informing the project members a source has been added
    text = user.username + ' added source ' + source.title + ' to ' + project.title
    createNotification(member, user._id, source.projectId, text) for member in project.members
    return source._id

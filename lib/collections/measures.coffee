@Measures = new Mongo.Collection 'measures'

Measures.allow
  update: (userId, measure) -> ownsProjectItem userId, measure
  remove: (userId, measure) -> ownsProjectItem userId, measure

Meteor.methods
  measureInsert: (measureAttributes) ->
    check this.userId, String
    check measureAttributes,
      projectId: String
      title: String
      description: String
      risks: Array
    user = Meteor.user()
    project = Projects.findOne measureAttributes.projectId
    if not project
      throw new Meteor.Error('invalid-measure', 'You must add a measure to a project')
    measure = _.extend measureAttributes,
      userId: user._id
      submitted: new Date()
      position: Measures.find({projectId: measureAttributes.projectId}).count()
      kind: 'measure'
    # Create the measure, save the id
    measure._id = Measures.insert measure
    # Now create a notification, informing the project members a measure has been added
    text = user.username + ' added measure ' + measure.title + ' to ' + project.title
    createNotification(member, user._id, measure.projectId, text) for member in project.members
    return measure._id

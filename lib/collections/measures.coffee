@Measures = new Mongo.Collection 'measures'

Measures.allow
  update: (userId, measure) -> ownsProjectItem userId, measure
  remove: (userId, measure) -> ownsProjectItem userId, measure

Meteor.methods
  measureInsert: (measureAttributes) ->
    check this.userId, String
    validateMeasure measureAttributes
    user = Meteor.user()
    measure = _.extend measureAttributes,
      userId: user._id
      submitted: new Date()
      position: 0
      kind: 'measure'
    # Update the positions of the existing measures
    Measures.update({_id: m._id}, {$set: {position: m.position+1}}) for m in Measures.find({projectId: measure.projectId}).fetch()
    # Create the measure, save the id
    measure._id = Measures.insert measure
    # Now create a notification, informing the project members a measure has been added
    project = Projects.findOne measure.projectId
    text = user.username + ' added measure ' + measure.title + ' to ' + project.title
    createNotification(member, user._id, measure.projectId, text) for member in project.members
    return measure._id

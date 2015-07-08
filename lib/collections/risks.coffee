@Risks = new Mongo.Collection 'risks'

Risks.allow
  update: (userId, risk) -> ownsProjectItem userId, risk
  remove: (userId, risk) -> ownsProjectItem userId, risk

Meteor.methods
  riskInsert: (riskAttributes) ->
    check this.userId, String
    validateRisk riskAttributes
    user = Meteor.user()
    risk = _.extend riskAttributes,
      userId: user._id
      submitted: new Date()
      position: 0
      kind: 'risk'
    # Update the positions of the existing risks
    Risks.update({_id: r._id}, {$set: {position: r.position+1}}) for r in Risks.find({projectId: risk.projectId}).fetch()
    # Create the risk, save the id
    risk._id = Risks.insert risk
    # Now create a notification, informing the project members a risk has been added
    project = Projects.findOne risk.projectId
    text = user.username + ' added risk ' + risk.title + ' to ' + project.title
    createNotification(member, user._id, risk.projectId, text) for member in project.members
    return risk._id

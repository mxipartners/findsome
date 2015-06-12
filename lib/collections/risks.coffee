@Risks = new Mongo.Collection 'risks'

Risks.allow
  update: (userId, risk) -> ownsProjectItem userId, risk
  remove: (userId, risk) -> ownsProjectItem userId, risk

Meteor.methods
  riskInsert: (riskAttributes) ->
    check this.userId, String
    check riskAttributes,
      projectId: String
      title: String
      description: String
      findings: Array
    user = Meteor.user()
    project = Projects.findOne riskAttributes.projectId
    if not project
      throw new Meteor.Error('invalid-risk', 'You must add a risk to a project')
    risk = _.extend riskAttributes,
      userId: user._id
      author: user.username
      submitted: new Date()
      kind: 'risk'
    # Create the risk, save the id
    risk._id = Risks.insert risk
    # Now create a notification, informing the project members a risk has been added
    text = user.username + ' added risk ' + risk.title + ' to ' + project.title
    createNotification(member, user._id, risk.projectId, text) for member in project.members
    return risk._id

@validateRisk = (risk) ->
  errors = {}
  if not risk.title
    errors.title = TAPi18n.__ "Please provide a title"
  if not risk.findings
    errors.findings = TAPi18n.__ "Please select one or more findings for the risk"
  return errors

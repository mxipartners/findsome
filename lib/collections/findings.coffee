@Findings = new Mongo.Collection 'findings'

Findings.allow
  update: (userId, finding) -> ownsProjectItem userId, finding
  remove: (userId, finding) -> ownsProjectItem userId, finding

Meteor.methods
  findingInsert: (findingAttributes) ->
    check this.userId, String
    check findingAttributes,
      projectId: String
      title: String
      description: String
      sources: Array
      criteria: [String]
    user = Meteor.user()
    project = Projects.findOne findingAttributes.projectId
    if not project
      throw new Meteor.Error('invalid-finding', 'You must add a finding to a project')
    finding = _.extend findingAttributes,
      userId: user._id
      submitted: new Date()
      position: Findings.find({projectId: findingAttributes.projectId}).count()
      kind: 'finding'
    # Create the finding, save the id
    finding._id = Findings.insert finding
    # Now create a notification, informing the project members a finding has been added
    text = user.username + ' added finding ' + finding.title + ' to ' + project.title
    createNotification(member, user._id, finding.projectId, text) for member in project.members
    return finding._id

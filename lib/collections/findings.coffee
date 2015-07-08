@Findings = new Mongo.Collection 'findings'

Findings.allow
  update: (userId, finding) -> ownsProjectItem userId, finding
  remove: (userId, finding) -> ownsProjectItem userId, finding

Meteor.methods
  findingInsert: (findingAttributes) ->
    check this.userId, String
    validateFinding findingAttributes
    user = Meteor.user()
    finding = _.extend findingAttributes,
      userId: user._id
      submitted: new Date()
      position: 0
      kind: 'finding'
    # Update the positions of the existing findings
    Findings.update({_id: f._id}, {$set: {position: f.position+1}}) for f in Findings.find({projectId: finding.projectId}).fetch()
    # Create the finding, save the id
    finding._id = Findings.insert finding
    # Now create a notification, informing the project members a finding has been added
    project = Projects.findOne finding.projectId
    text = user.username + ' added finding ' + finding.title + ' to ' + project.title
    createNotification(member, user._id, finding.projectId, text) for member in project.members
    return finding._id

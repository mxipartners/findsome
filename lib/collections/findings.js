Findings = new Mongo.Collection('findings');

Findings.allow({
  update: function(userId, finding) { return ownsDocument(userId, finding); },
  remove: function(userId, finding) { return ownsDocument(userId, finding); },
});

Meteor.methods({
  findingInsert: function(findingAttributes) {
    check(this.userId, String);
    check(findingAttributes, {
      projectId: String,
      body: String
    });
    var user = Meteor.user();
    var project = Projects.findOne(findingAttributes.projectId);
    if (!project)
      throw new Meteor.Error('invalid-finding', 'You must add a finding to a project');
    finding = _.extend(findingAttributes, {
      userId: user._id,
      author: user.username,
      submitted: new Date()
    });
    // update the project with the number of findings
    Projects.update(finding.projectId, {$inc: {findingsCount: 1}});
    // create the finding, save the id
    finding._id = Findings.insert(finding);
    // now create a notification, informing the user that there's been a finding
    createNotification(finding);
    return finding._id;
  }
});

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
      title: String,
      description: String,
      sources: Array
    });
    var user = Meteor.user();
    var project = Projects.findOne(findingAttributes.projectId);
    if (!project)
      throw new Meteor.Error('invalid-finding', 'You must add a finding to a project');
    finding = _.extend(findingAttributes, {
      userId: user._id,
      author: user.username,
      submitted: new Date(),
      kind: 'finding'
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

validateFinding = function (finding) {
  var errors = {};

  if (!finding.title)
    errors.title = "Please provide a title for the finding";

  if (!finding.description)
      errors.description = "Please provide a description for the finding";

  if (!finding.sources)
    errors.sources =  "Please select one or more sources for the finding";

  return errors;
}

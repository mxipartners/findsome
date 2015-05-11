Risks = new Mongo.Collection('risks');

Risks.allow({
  update: function(userId, risk) { return ownsDocument(userId, risk); },
  remove: function(userId, risk) { return ownsDocument(userId, risk); },
});

Meteor.methods({
  riskInsert: function(riskAttributes) {
    check(this.userId, String);
    check(riskAttributes, {
      projectId: String,
      title: String,
      description: String,
      findings: Array
    });
    var user = Meteor.user();
    var project = Projects.findOne(riskAttributes.projectId);
    if (!project)
      throw new Meteor.Error('invalid-risk', 'You must add a risk to a project');
    risk = _.extend(riskAttributes, {
      userId: user._id,
      author: user.username,
      submitted: new Date(),
      kind: 'risk'
    });
    // update the project with the number of risks
    Projects.update(risk.projectId, {$inc: {risksCount: 1}});
    // create the risk, save the id
    risk._id = Risks.insert(risk);
    // now create a notification, informing the project members a risk has been added
    for (i = 0; i < project.members.length; i++)
    {
      createNotification(project.members[i], user._id, risk.projectId,
        user.username + ' added risk ' + risk.title + ' to ' + project.title);
    };
    return risk._id;
  }
});

validateRisk = function(risk) {
  var errors = {};

  if (!risk.title)
    errors.title = "Please provide a title for the risk";

  if (!risk.description)
      errors.description = "Please provide a description for the risk";

  if (!risk.findings)
    errors.findings = "Please select one or more findings for the risk";

  return errors;
}

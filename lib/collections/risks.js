Risks = new Mongo.Collection('risks');

Risks.allow({
  update: function(userId, risk) { return ownsProjectItem(userId, risk); },
  remove: function(userId, risk) { return ownsProjectItem(userId, risk); },
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
    errors.title = TAPi18n.__("Please provide a title");

  if (!risk.findings)
    errors.findings = TAPi18n.__("Please select one or more findings for the risk");

  return errors;
}

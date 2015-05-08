Meteor.publish('projects', function() {
  return Projects.find();
});

Meteor.publish('risks', function(projectId) {
  check(projectId, String);
  return Risks.find({projectId: projectId});
});

Meteor.publish('findings', function(projectId) {
  check(projectId, String);
  return Findings.find({projectId: projectId});
});

Meteor.publish('sources', function(projectId) {
  check(projectId, String);
  return Sources.find({projectId: projectId});
});

Meteor.publish('notifications', function() {
  return Notifications.find({userId: this.userId, read: false});
});

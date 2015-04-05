Notifications = new Mongo.Collection('notifications');

Notifications.allow({
  update: function(userId, doc, fieldNames) {
    return ownsDocument(userId, doc) &&
      fieldNames.length === 1 && fieldNames[0] === 'read';
  }
});

createNotification = function(doc) {
  var project = Projects.findOne(doc.projectId);
  if (doc.userId !== project.userId) {
    Notifications.insert({
      userId: project.userId,
      projectId: project._id,
      projectTitle: project.title,
      docId: doc._id,
      authorName: doc.author,
      kind: doc.kind,
      read: false
    });
  }
};

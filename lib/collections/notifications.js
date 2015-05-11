Notifications = new Mongo.Collection('notifications');

Notifications.allow({
  update: function(userId, doc, fieldNames, modifier) {
    return false;
  },
  remove: function(userId, doc) {
    return ownsDocument(userId, doc);
  }
});

createNotification = function(userId, authorId, projectId, notificationText) {
  if (userId !== authorId) {
    Notifications.insert({
      userId: userId,
      projectId: projectId,
      notificationText: notificationText
    });
  }
};

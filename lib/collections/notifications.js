Notifications = new Mongo.Collection('notifications');

Notifications.allow({
  update: function(userId, notification, fieldNames, modifier) {
    return false;
  },
  remove: function(userId, notification) {
    return userId === notification.userId;
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

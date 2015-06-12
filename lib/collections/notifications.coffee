@Notifications = new Mongo.Collection 'notifications'

Notifications.allow
  update: (userId, notification, fieldNames, modifier) -> false
  remove: (userId, notification) -> userId == notification.userId

@createNotification = (userId, authorId, projectId, notificationText) ->
  if userId != authorId
    Notifications.insert
      userId: userId
      projectId: projectId
      notificationText: notificationText

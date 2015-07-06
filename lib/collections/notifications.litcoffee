Users are notified of certain actions by other users.

    @Notifications = new Mongo.Collection 'notifications'

Updates to the notifications are not allowed since notifications are simply
dismissed when read. Only the recipient of a notification is allowed to remove
the notification.

    Notifications.allow
      update: (userId, notification, fieldNames, modifier) -> false
      remove: (userId, notification) -> userId == notification.userId

To create a notification, recipient, sender, project, and text are needed.
Note a subtle bug here: the notification text is put together by the sender
and consequently will be in the language of the sender.

    @createNotification = (userId, authorId, projectId, notificationText) ->

Before we insert the notification, make sure the sender isn't notifying
her- or himself.

      if userId != authorId
        Notifications.insert
          userId: userId
          projectId: projectId
          notificationText: notificationText

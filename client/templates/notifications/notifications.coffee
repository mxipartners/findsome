notifications = -> Notifications.find userId: Meteor.userId()

Template.notifications.helpers
  notifications: -> notifications()
  notificationCount: -> notifications().count()

Template.notifications.events
  'click .markread': ->
    Notifications.remove(notification._id) for notification in notifications().fetch()

Template.notificationItem.helpers
  notificationProjectPath: -> Router.routes.projectPage.path _id: this.projectId

Template.notificationItem.events
  'click a': -> Notifications.remove this._id

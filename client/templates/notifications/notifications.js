Template.notifications.helpers({
  notifications: function() {
    return Notifications.find({userId: Meteor.userId()});
  },
  notificationCount: function(){
    return Notifications.find({userId: Meteor.userId()}).count();
  }
});

Template.notificationItem.helpers({
  notificationProjectPath: function() {
    return Router.routes.projectPage.path({_id: this.projectId});
  }
});

Template.notificationItem.events({
  'click a': function() {
    Notifications.remove(this._id);
  }
});

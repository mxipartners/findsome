Template.projectItem.helpers({
  ownProject: function() {
    return this.userId === Meteor.userId();
  }
});


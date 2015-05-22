Router.configure({
  layoutTemplate: 'layout',
  loadingTemplate: 'loading',
  notFoundTemplate: 'notFound',
  waitOn: function() {
    return [Meteor.subscribe('projects'),
            Meteor.subscribe('notifications')];
  }
});

Router.route('/projects/:_id/edit', {
  name: 'projectEdit',
  data: function() { return Projects.findOne(this.params._id); },
  waitOn: function() {
    return [Meteor.subscribe('usernames')];
  }
});

Router.route('/projects/new', {
  name: 'projectNew',
  waitOn: function() {
    return [Meteor.subscribe('usernames')];
  }
});

Router.route('/projects/:_id', {
  name: 'projectPage',
  waitOn: function() {
    return [Meteor.subscribe('measures', this.params._id),
            Meteor.subscribe('risks', this.params._id),
            Meteor.subscribe('findings', this.params._id),
            Meteor.subscribe('sources', this.params._id)];
  },
  data: function() { return Projects.findOne(this.params._id); }
});

Router.route('/', {name: 'projectsList'});

var requireLogin = function() {
  if (! Meteor.user()) {
    if (Meteor.loggingIn()) {
      this.render(this.loadingTemplate);
    } else {
      this.render('accessDenied');
    }
  } else {
    this.next();
  }
}

Router.onBeforeAction('dataNotFound', {only: 'projectPage'});
Router.onBeforeAction(requireLogin);

Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  waitOn: -> [Meteor.subscribe('projects'),
              Meteor.subscribe('checklists'),
              Meteor.subscribe('notifications'),
              Meteor.subscribe('usernames')]

Router.route '/projects/:_id',
  name: 'projectPage'
  data: -> Projects.findOne this.params._id
  waitOn: ->
    projectId = this.params._id
    [Meteor.subscribe('measures', projectId),
     Meteor.subscribe('risks', projectId),
     Meteor.subscribe('findings', projectId),
     Meteor.subscribe('sources', projectId),
     Meteor.subscribe('all_criteria')]

Router.route '/checklists/:_id',
  name: 'checklistPage'
  data: -> Checklists.findOne this.params._id
  waitOn: ->
    checklistId = this.params._id
    [Meteor.subscribe('criteria', checklistId)]

Router.route '/', name: 'home'

requireLogin = ->
  if Meteor.user()
    this.next()
  else
    this.render(if Meteor.loggingIn() then this.loadingTemplate else 'accessDenied')

Router.onBeforeAction requireLogin

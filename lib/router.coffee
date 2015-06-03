Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  waitOn: -> [Meteor.subscribe('projects'), Meteor.subscribe('notifications')]

Router.route '/projects/:_id/edit',
  name: 'projectEdit'
  data: -> Projects.findOne this.params._id
  waitOn: -> Meteor.subscribe 'usernames'

Router.route '/projects/new',
  name: 'projectNew'
  waitOn: -> Meteor.subscribe 'usernames'

Router.route '/projects/:_id',
  name: 'projectPage'
  data: -> Projects.findOne this.params._id
  waitOn: ->
    projectId = this.params._id
    [Meteor.subscribe('measures', projectId),
     Meteor.subscribe('risks', projectId),
     Meteor.subscribe('findings', projectId),
     Meteor.subscribe('sources', projectId)]

Router.route '/', name: 'projectsList'

requireLogin = ->
  if Meteor.user()
    this.next()
  else
    this.render(if Meteor.loggingIn() then this.loadingTemplate else 'accessDenied')

Router.onBeforeAction 'dataNotFound', only: 'projectPage'
Router.onBeforeAction requireLogin

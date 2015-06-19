Template.home.helpers
  projects: -> Projects.find {}, {sort: {submitted: -1}}
  checklists: -> Checklists.find {}, {sort: {submitted: -1}}

Template.home.onCreated ->
  Session.setDefault 'currentHomeTab', 'projects'

Template.home.onRendered ->
  current = this.$('a[href="#' + Session.get('currentHomeTab') + '"]')
  current.tab 'show'

Template.home.events
  'shown.bs.tab': (e) ->
    Session.set 'currentHomeTab', e.target.href.split('#')[1]

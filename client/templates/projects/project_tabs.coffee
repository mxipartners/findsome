Template.projectTabs.onCreated ->
  Session.setDefault 'currentProjectTab', 'sources'

Template.projectTabs.onRendered ->
  current = this.$('a[href="#' + Session.get('currentProjectTab') + '"]')
  current.tab 'show'

Template.projectTabs.events
  'shown.bs.tab': (e) ->
    Session.set 'currentProjectTab', e.target.href.split('#')[1]

Template.projectTabs.helpers
  sources_count: -> Sources.find({projectId: this._id}).count()
  findings_count: -> Findings.find({projectId: this._id}).count()
  risks_count: -> Risks.find({projectId: this._id}).count()
  measures_count: -> Measures.find({projectId: this._id}).count()

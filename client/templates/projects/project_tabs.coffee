Template.projectTabs.onCreated ->
  Session.setDefault 'currentProjectTab', 'sources'

Template.projectTabs.onRendered ->
  current = this.$('a[href="#' + Session.get('currentProjectTab') + '"]')
  current.tab 'show'

Template.projectTabs.events
  'shown.bs.tab': (e) ->
    Session.set 'currentProjectTab', e.target.href.split('#')[1]

Template.projectTabs.helpers
  sources: -> Sources.find {projectId: this._id}
  sources_count: -> Sources.find({projectId: this._id}).count()
  findings: -> Findings.find {projectId: this._id}
  findings_count: -> Findings.find({projectId: this._id}).count()
  risks: -> Risks.find {projectId: this._id}
  risks_count: -> Risks.find({projectId: this._id}).count()
  measures: -> Measures.find {projectId: this._id}
  measures_count: -> Measures.find({projectId: this._id}).count()
  has_sources: -> Sources.find({projectId: this._id}).count() > 0
  has_findings: -> Findings.find({projectId: this._id}).count() > 0
  has_risks: -> Risks.find({projectId: this._id}).count() > 0

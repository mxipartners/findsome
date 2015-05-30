Template.projectTabs.onCreated(function() {
  Session.setDefault('currentProjectTab', 'sources');
});

Template.projectTabs.onRendered(function() {
  current = this.$('a[href="#' + Session.get('currentProjectTab') + '"]');
  current.tab('show');
});

Template.projectTabs.events({
  'shown.bs.tab': function(e) {
    Session.set('currentProjectTab', e.target.href.split('#')[1]);
  }
});

Template.projectTabs.helpers({
  sources: function() {
    return Sources.find({projectId: this._id});
  },
  sources_count: function() {
    return Sources.find({projectId: this._id}).count();
  },
  findings: function() {
    return Findings.find({projectId: this._id});
  },
  findings_count: function() {
    return Findings.find({projectId: this._id}).count();
  },
  risks: function() {
    return Risks.find({projectId: this._id});
  },
  risks_count: function() {
    return Risks.find({projectId: this._id}).count();
  },
  measures: function() {
    return Measures.find({projectId: this._id});
  },
  measures_count: function() {
    return Measures.find({projectId: this._id}).count();
  },
  has_sources: function() {
    return Sources.find({projectId: this._id}).count() > 0;
  },
  has_findings: function() {
    return Findings.find({projectId: this._id}).count() > 0;
  },
  has_risks: function() {
    return Risks.find({projectId: this._id}).count() > 0;
  }
});

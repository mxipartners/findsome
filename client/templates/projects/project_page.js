Template.projectPage.helpers({
  risks: function() {
    return Risks.find({projectId: this._id});
  },
  findings: function() {
    return Findings.find({projectId: this._id});
  },
  has_findings: function() {
    return Findings.find({projectId: this._id}).count() > 0;
  },
  sources: function() {
    return Sources.find({projectId: this._id});
  },
  has_sources: function() {
    return Sources.find({projectId: this._id}).count() > 0;
  }
});

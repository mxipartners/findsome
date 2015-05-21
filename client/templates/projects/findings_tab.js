Template.findingsTab.helpers({
  findings: function() {
    return Findings.find({projectId: this._id});
  },
  has_sources: function() {
    return Sources.find({projectId: this._id}).count() > 0;
  }
});

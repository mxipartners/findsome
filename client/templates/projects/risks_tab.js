Template.risksTab.helpers({
  risks: function() {
    return Risks.find({projectId: this._id});
  },
  has_findings: function() {
    return Findings.find({projectId: this._id}).count() > 0;
  }
});

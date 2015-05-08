Template.projectReport.helpers({
  risks: function() {
    return Risks.find({projectId: this._id});
  },
  riskFindings: function() {
    return Findings.find({_id: {$in: this.findings}});
  },
  findings: function() {
    return Findings.find({projectId: this._id});
  },
  sources: function() {
    return Sources.find({projectId: this._id});
  },
  findingSources: function() {
    return Sources.find({_id: {$in: this.sources}});
  }
});

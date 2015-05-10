Template.projectReport.helpers({
  risks: function() {
    return Risks.find({projectId: this._id});
  },
  has_risks: function() {
    return Risks.find({projectId: this._id}).count() > 0;
  },
  riskFindings: function() {
    return Findings.find({_id: {$in: this.findings}});
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
  },
  findingSources: function() {
    return Sources.find({_id: {$in: this.sources}});
  }
});

Template.projectSourcesTable.helpers({
  sources: function() {
    return Sources.find({projectId: this._id});
  },
  has_sources: function() {
    return Sources.find({projectId: this._id}).count() > 0;
  }
});

Template.projectFindingsTable.helpers({
  findings: function() {
    return Findings.find({projectId: this._id});
  },
  has_findings: function() {
    return Findings.find({projectId: this._id}).count() > 0;
  },
  findingSources: function() {
    return Sources.find({_id: {$in: this.sources}});
  }
});

Template.projectRisksTable.helpers({
  risks: function() {
    return Risks.find({projectId: this._id});
  },
  has_risks: function() {
    return Risks.find({projectId: this._id}).count() > 0;
  },
  riskFindings: function() {
    return Findings.find({_id: {$in: this.findings}});
  }
});

Template.projectMeasuresTable.helpers({
  measures: function() {
    return Measures.find({projectId: this._id});
  },
  has_measures: function() {
    return Measures.find({projectId: this._id}).count() > 0;
  },
  measureRisks: function() {
    return Risks.find({_id: {$in: this.risks}});
  }
});

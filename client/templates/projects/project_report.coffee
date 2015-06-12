Template.projectSourcesTable.helpers
  sources: -> Sources.find {projectId: this._id}
  has_sources: -> Sources.find({projectId: this._id}).count() > 0

Template.projectFindingsTable.helpers
  findings: -> Findings.find {projectId: this._id}
  has_findings: -> Findings.find({projectId: this._id}).count() > 0
  findingSources: -> Sources.find {_id: {$in: this.sources}}

Template.projectRisksTable.helpers
  risks: -> Risks.find {projectId: this._id}
  has_risks: -> Risks.find({projectId: this._id}).count() > 0
  riskFindings: -> Findings.find {_id: {$in: this.findings}}

Template.projectMeasuresTable.helpers
  measures: -> Measures.find {projectId: this._id}
  has_measures: -> Measures.find({projectId: this._id}).count() > 0
  measureRisks: -> Risks.find {_id: {$in: this.risks}}

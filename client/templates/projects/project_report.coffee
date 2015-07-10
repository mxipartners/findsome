Template.projectChecklistsTables.helpers
  checklists: -> Checklists.find {_id: {$in: this.checklists or []}}
  criteria: -> Criteria.find {checklistId: this._id}, {sort: position: 1}

Template.projectSourcesTable.helpers
  sources: -> Sources.find {}, {sort: {position: 1}}
  has_sources: -> Sources.find().count() > 0

Template.projectFindingsTable.helpers
  findings: -> Findings.find {}, {sort: {position: 1}}
  has_findings: -> Findings.find().count() > 0
  findingSources: -> Sources.find {_id: {$in: this.sources or []}}
  findingCriteria: -> Criteria.find {_id: {$in: this.criteria or []}}
  has_checklists: -> this.checklists and this.checklists.length > 0
  project_has_checklists: ->
    checklists = Template.parentData().checklists
    checklists and checklists.length > 0

Template.projectRisksTable.helpers
  risks: -> Risks.find {}, {sort: {position: 1}}
  has_risks: -> Risks.find().count() > 0
  riskFindings: -> Findings.find {_id: {$in: this.findings or []}}

Template.projectMeasuresTable.helpers
  measures: -> Measures.find {}, {sort: {position: 1}}
  has_measures: -> Measures.find().count() > 0
  measureRisks: -> Risks.find {_id: {$in: this.risks or []}}

Template.risksList.helpers
  risks: -> Risks.find {projectId: this._id}
  has_findings: -> Findings.find({projectId: this._id}).count() > 0

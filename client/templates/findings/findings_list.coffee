Template.findingsList.helpers
  findings: -> Findings.find {projectId: this._id}
  has_sources: -> Sources.find({projectId: this._id}).count() > 0

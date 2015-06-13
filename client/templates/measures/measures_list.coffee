Template.measuresList.helpers
  measures: -> Measures.find {projectId: this._id}
  has_risks: -> Risks.find({projectId: this._id}).count() > 0

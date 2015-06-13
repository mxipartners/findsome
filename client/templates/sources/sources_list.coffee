Template.sourcesList.helpers
  sources: -> Sources.find {projectId: this._id}

Template.projectPage.helpers({
  findings: function() {
    return Findings.find({projectId: this._id});
  },
  sources: function() {
    return Sources.find({projectId: this._id});
  }
});


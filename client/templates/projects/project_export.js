Template.projectExport.helpers({
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

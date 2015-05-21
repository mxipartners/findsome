Template.sourcesTab.helpers({
  sources: function() {
    return Sources.find({projectId: this._id});
  }
});

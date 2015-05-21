Template.measuresTab.helpers({
  measures: function() {
    return Measures.find({projectId: this._id});
  },
  has_risks: function() {
    return Risks.find({projectId: this._id}).count() > 0;
  }
});

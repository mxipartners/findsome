Template.measureEdit.created = function() {
  Session.set('measureEditErrors', {});
}

Template.measureEdit.rendered = function() {
  $(".risk-select").select2({
    placeholder: "Select risks"
  });
};

Template.measureEdit.helpers({
  errorMessage: function(field) {
    return Session.get('measureEditErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('measureEditErrors')[field] ? 'has-error' : '';
  },
  risks: function() {
    return Risks.find();
  },
  riskIsSelected: function() {
    var measure = Template.parentData();
    return measure.risks.indexOf(this._id) > -1;
  }
});

Template.measureEdit.events({
  'submit form': function(e, template) {
    e.preventDefault();

    var currentMeasureId = this._id;
    var projectId = this.projectId;

    var $title = $(e.target).find('[name=title]');
    var $description = $(e.target).find('[name=description]');
    var $risks = $(e.target).find('[name=risks]');
    var measureProperties = {
      title: $title.val(),
      description: $description.val(),
      risks: $risks.val(),
    };

    Session.set('measure_title', {});
    Session.set('measureEditErrors', {});
    var errors = validateMeasure(measureProperties);
    if (errors.title)
      Session.set('measure_title', errors);
    if (errors.risks)
      Session.set('measureEditErrors', errors);
    if (errors.title || errors.risks)
      return false;

    Measures.update(currentMeasureId, {$set: measureProperties}, function(error) {
      if (error) {
        throwError(error.reason);
      } else {
        Router.go('projectPage', {_id: projectId});
      }
    });
  }
});

Template.deleteMeasure.events({
  'click .delete': function(e) {
    var projectId = this.projectId;
    Projects.update(projectId, {$inc: {measuresCount: -1}});
    Measures.remove(this._id);
    // Make sure the backdrop is hidden before we go to the project page.
    $('#deleteMeasure').on('hidden.bs.modal', function() {
      Router.go('projectPage', {_id: projectId});
    }).modal('hide');
  }
});

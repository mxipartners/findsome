Template.measureSubmit.created = function() {
  Session.set('measureSubmitErrors', {});
}

Template.measureSubmit.rendered = function() {
  $(".risk-select").select2({
    placeholder: "Select risks"
  });
};

Template.measureSubmit.helpers({
  errorMessage: function(field) {
    return Session.get('measureSubmitErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('measureSubmitErrors')[field] ? 'has-error' : '';
  },
  risks: function() {
    return Risks.find();
  }
});

Template.measureSubmit.events({
  'submit form': function(e, template) {
    e.preventDefault();

    var $title = $(e.target).find('[name=title]');
    var $description = $(e.target).find('[name=description]');
    var $risks = $(e.target).find('[name=risks]');
    var measure = {
      title: $title.val(),
      description: $description.val(),
      risks: $risks.val(),
      projectId: template.data._id
    };

    Session.set('measureSubmitErrors', {});
    Session.set('measure_title', {});
    var errors = validateMeasure(measure);
    if (errors.title)
      Session.set('measure_title', errors);
    if (errors.risks)
      Session.set('measureSubmitErrors', errors);
    if (errors.title || errors.risks)
      return false;

    Meteor.call('measureInsert', measure, function(error, measureId) {
      if (error){
        throwError(error.reason);
      } else {
        $title.val('');
        $description.val('');
      }
    });
  }
});

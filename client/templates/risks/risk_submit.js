Template.riskSubmit.created = function() {
  Session.set('riskSubmitErrors', {});
}

Template.riskSubmit.helpers({
  errorMessage: function(field) {
    return Session.get('riskSubmitErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('riskSubmitErrors')[field] ? 'has-error' : '';
  },
  findings: function() {
    return Findings.find();
  }
});

Template.riskSubmit.events({
  'submit form': function(e, template) {
    e.preventDefault();

    var $title = $(e.target).find('[name=title]');
    var $description = $(e.target).find('[name=description]');
    var $findings = $(e.target).find('[name=findings]');
    var risk = {
      title: $title.val(),
      description: $description.val(),
      findings: $findings.val(),
      projectId: template.data._id
    };

    Session.set('riskSubmitErrors', {});
    Session.set('risk_title', {});
    Session.set('risk_description', {});
    var errors = validateRisk(risk);
    if (errors.title)
      Session.set('risk_title', errors);
    if (errors.description)
      Session.set('risk_description', errors);
    if (errors.findings)
      Session.set('riskSubmitErrors', errors);
    if (errors.title || errors.description || errors.findings)
      return false;

    Meteor.call('riskInsert', risk, function(error, riskId) {
      if (error){
        throwError(error.reason);
      } else {
        $title.val('');
        $description.val('');
      }
    });
  }
});
Template.riskEdit.created = function() {
  Session.set('riskEditErrors', {});
}

Template.riskEdit.rendered = function() {
  $(".finding-select").select2({
    placeholder: "Select findings"
  });
};

Template.riskEdit.helpers({
  errorMessage: function(field) {
    return Session.get('riskEditErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('riskEditErrors')[field] ? 'has-error' : '';
  },
  findings: function() {
    return Findings.find();
  },
  findingIsSelected: function() {
    var risk = Template.parentData();
    return risk.findings.indexOf(this._id) > -1;
  }
});

Template.riskEdit.events({
  'submit form': function(e, template) {
    e.preventDefault();

    var currentRiskId = this._id;
    var projectId = this.projectId;

    var $title = $(e.target).find('[name=title]');
    var $description = $(e.target).find('[name=description]');
    var $findings = $(e.target).find('[name=findings]');
    var riskProperties = {
      title: $title.val(),
      description: $description.val(),
      findings: $findings.val(),
    };

    Session.set('risk_title', {});
    Session.set('riskEditErrors', {});
    var errors = validateRisk(riskProperties);
    if (errors.title)
      Session.set('risk_title', errors);
    if (errors.findings)
      Session.set('riskEditErrors', errors);
    if (errors.title || errors.findings)
      return false;

    Risks.update(currentRiskId, {$set: riskProperties}, function(error) {
      if (error) {
        throwError(error.reason);
      } else {
        Session.set('itemEdited', null);
        Router.go('projectPage', {_id: projectId});
      }
    });
  }
});

Template.deleteRisk.events({
  'click .delete': function(e) {
    var projectId = this.projectId;
    Projects.update(projectId, {$inc: {risksCount: -1}});
    Risks.remove(this._id);
    // Make sure the backdrop is hidden before we go to the project page.
    $('#deleteRisk').on('hidden.bs.modal', function() {
      Session.set('itemEdited', null);
      Router.go('projectPage', {_id: projectId});
    }).modal('hide');
  }
});

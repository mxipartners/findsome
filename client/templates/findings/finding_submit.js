Template.findingSubmit.created = function() {
  Session.set('findingSubmitErrors', {});
}

Template.findingSubmit.helpers({
  errorMessage: function(field) {
    return Session.get('findingSubmitErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('findingSubmitErrors')[field] ? 'has-error' : '';
  },
  sources: function() {
    return Sources.find();
  }
});

Template.findingSubmit.events({
  'submit form': function(e, template) {
    e.preventDefault();

    var $body = $(e.target).find('[name=body]');
    var $sources = $(e.target).find('[name=sources]');
    var finding = {
      body: $body.val(),
      sources: $sources.val(),
      projectId: template.data._id
    };

    var errors = validateFinding(finding);
    if (errors.body || errors.sources)
      return Session.set('findingSubmitErrors', errors);

    Meteor.call('findingInsert', finding, function(error, findingId) {
      if (error){
        throwError(error.reason);
      } else {
        $body.val('');
        Session.set('findingSubmitErrors', {})
      }
    });
  }
});

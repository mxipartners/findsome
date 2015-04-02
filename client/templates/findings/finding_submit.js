Template.findingSubmit.created = function() {
  Session.set('findingSubmitErrors', {});
}

Template.findingSubmit.helpers({
  errorMessage: function(field) {
    return Session.get('findingSubmitErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('findingSubmitErrors')[field] ? 'has-error' : '';
  }
});

Template.findingSubmit.events({
  'submit form': function(e, template) {
    e.preventDefault();

    var $body = $(e.target).find('[name=body]');
    var finding = {
      body: $body.val(),
      projectId: template.data._id
    };

    var errors = {};
    if (! finding.body) {
      errors.body = "Please write some content";
      return Session.set('findingSubmitErrors', errors);
    }

    Meteor.call('findingInsert', finding, function(error, findingId) {
      if (error){
        throwError(error.reason);
      } else {
        $body.val('');
      }
    });
  }
});

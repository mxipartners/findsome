Template.sourceSubmit.created = function() {
  Session.set('sourceSubmitErrors', {});
}

Template.sourceSubmit.helpers({
  errorMessage: function(field) {
    return Session.get('sourceSubmitErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('sourceSubmitErrors')[field] ? 'has-error' : '';
  }
});

Template.sourceSubmit.events({
  'submit form': function(e, template) {
    e.preventDefault();

    var $body = $(e.target).find('[name=body]');
    var source = {
      body: $body.val(),
      projectId: template.data._id
    };

    var errors = {};
    if (! source.body) {
      errors.body = "Please write some content";
      return Session.set('sourceSubmitErrors', errors);
    }

    Meteor.call('sourceInsert', source, function(error, sourceId) {
      if (error){
        throwError(error.reason);
      } else {
        $body.val('');
      }
    });
  }
});

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

    var $title = $(e.target).find('[name=title]');
    var $description = $(e.target).find('[name=description]');
    var source = {
      title: $title.val(),
      description: $description.val(),
      projectId: template.data._id
    };

    var errors = validateSource(source);
    if (errors.title || errors.description)
      return Session.set('sourceSubmitErrors', errors);

    Meteor.call('sourceInsert', source, function(error, sourceId) {
      if (error){
        throwError(error.reason);
      } else {
        $title.val('');
        $description.val('');
      }
    });
  }
});

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

    var $title = $(e.target).find('[name=title]');
    var $description = $(e.target).find('[name=description]');
    var $sources = $(e.target).find('[name=sources]');
    var finding = {
      title: $title.val(),
      description: $description.val(),
      sources: $sources.val(),
      projectId: template.data._id
    };

    var errors = validateFinding(finding);
    if (errors.title || errors.description || errors.sources)
      return Session.set('findingSubmitErrors', errors);

    Meteor.call('findingInsert', finding, function(error, findingId) {
      if (error){
        throwError(error.reason);
      } else {
        $title.val('');
        $description.val('');
        Session.set('findingSubmitErrors', {})
      }
    });
  }
});

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

    Session.set('source_title', {});
    Session.set('source_description', {});
    var errors = validateSource(source);
    if (errors.title)
      Session.set('source_title', errors);
    if (errors.description)
      Session.set('source_description', errors);
    if (errors.title || errors.description)
      return false;

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

Template.projectNew.events({
  'submit form': function(e) {
    e.preventDefault();

    var project = {
      title: $(e.target).find('[name=title]').val(),
      description: $(e.target).find('[name=description]').val()
    };

    Session.set('titleErrors', {});
    Session.set('descriptionErrors', {});
    var errors = validateProject(project);
    if (errors.title)
      Session.set('titleErrors', errors);
    if (errors.description)
      Session.set('descriptionErrors', errors);
    if (errors.title || errors.description)
      return false;

    Meteor.call('projectInsert', project, function(error, result) {
      // display the error to the user and abort
      if (error)
        return throwError(error.reason);

      // show this result but route anyway
      if (result.projectExists)
        throwError('This project has already been created');

      Router.go('projectPage', {_id: result._id});
    });
  }
});

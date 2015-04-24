Template.projectNew.events({
  'submit form': function(e) {
    e.preventDefault();

    var project = {
      title: $(e.target).find('[name=title]').val(),
      description: $(e.target).find('[name=description]').val()
    };

    Session.set('project_title', {});
    Session.set('project_description', {});
    var errors = validateProject(project);
    if (errors.title)
      Session.set('project_title', errors);
    if (errors.description)
      Session.set('project_description', errors);
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

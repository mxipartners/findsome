Template.projectEdit.events({
  'submit form': function(e) {
    e.preventDefault();

    var currentProjectId = this._id;

    var projectProperties = {
      title: $(e.target).find('[name=title]').val(),
      description: $(e.target).find('[name=description]').val()
    }

    Session.set('project_title', {});
    Session.set('project_description', {});
    var errors = validateProject(projectProperties);
    if (errors.title)
      Session.set('project_title', errors);
    if (errors.description)
      Session.set('project_description', errors);
    if (errors.title || errors.description)
      return false;

    Projects.update(currentProjectId, {$set: projectProperties}, function(error) {
      if (error) {
        // display the error to the user
        throwError(error.reason);
      } else {
        Router.go('projectPage', {_id: currentProjectId});
      }
    });
  }
});

Template.deleteProject.events({
  'click .delete': function(e) {
    Projects.remove(this._id);
    // Make sure the backdrop is hidden before we go to the project list.
    $('#deleteProject').on('hidden.bs.modal', function() {
      Router.go('projectsList');
    }).modal('hide');
  }
});

Template.projectEdit.created = function() {
  Session.set('projectEditErrors', {});
}

Template.projectEdit.helpers({
  errorMessage: function(field) {
    return Session.get('projectEditErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('projectEditErrors')[field] ? 'has-error' : '';
  }
});

Template.projectEdit.events({
  'submit form': function(e) {
    e.preventDefault();

    var currentProjectId = this._id;

    var projectProperties = {
      title: $(e.target).find('[name=title]').val(),
      description: $(e.target).find('[name=description]').val()
    }

    var errors = validateProject(projectProperties);
    if (errors.title || errors.description)
      return Session.set('projectEditErrors', errors);

    Projects.update(currentProjectId, {$set: projectProperties}, function(error) {
      if (error) {
        // display the error to the user
        throwError(error.reason);
      } else {
        Router.go('projectPage', {_id: currentProjectId});
      }
    });
  },

  'click .delete': function(e) {
    e.preventDefault();

    if (confirm("Delete this project?")) {
      var currentProjectId = this._id;
      Projects.remove(currentProjectId);
      Router.go('projectsList');
    }
  }
});

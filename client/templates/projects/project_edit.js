Template.projectEdit.created = function() {
  Session.set('projectEditErrors', {});
};

Template.projectEdit.rendered = function() {
  $(".member-select").select2({
    placeholder: TAPi18n.__("Select project members")
  });
};

Template.projectEdit.helpers({
  usernames: function() {
    return Meteor.users.find();
  },
  userIsMember: function() {
    var project = Template.parentData();
    return project.members.indexOf(this._id) > -1;
  },
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
      description: $(e.target).find('[name=description]').val(),
      members: $(e.target).find('[name=members]').val()
    };

    Session.set('project_title', {});
    Session.set('projectEditErrors', {});
    var errors = validateProject(projectProperties);

    if (errors.title)
      Session.set('project_title', errors);
    if (errors.members)
      Session.set('projectEditErrors', errors);
    if (errors.title || errors.members)
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

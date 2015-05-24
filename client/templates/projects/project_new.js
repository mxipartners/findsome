Template.projectNew.created = function() {
  Session.set('projectNewErrors', {});
};

Template.projectNew.rendered = function() {
  $(".member-select").select2({
    placeholder: TAPi18n.__("Select project members")
  });
};

Template.projectNew.helpers({
  usernames: function() {
    return Meteor.users.find();
  },
  userIsCurrentUser: function() {
    return this._id === Meteor.userId();
  },
  errorMessage: function(field) {
    return Session.get('projectNewErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('projectNewErrors')[field] ? 'has-error' : '';
  }
});

Template.projectNew.events({
  'submit form': function(e) {
    e.preventDefault();

    var project = {
      title: $(e.target).find('[name=title]').val(),
      description: $(e.target).find('[name=description]').val(),
      members: $(e.target).find('[name=members]').val()
    };

    Session.set('project_title', {});
    Session.set('projectNewErrors', {});
    var errors = validateProject(project);
    if (errors.title)
      Session.set('project_title', errors);
    if (errors.members)
      Session.set('projectNewErrors', errors);
    if (errors.title || errors.members)
      return false;

    Meteor.call('projectInsert', project, function(error, result) {
      // display the error to the user and abort
      if (error)
        return throwError(error.reason);

      Router.go('projectPage', {_id: result._id});
    });
  }
});

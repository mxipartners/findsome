Template.sourceEdit.created = function() {
  Session.set('sourceEditErrors', {});
}

Template.sourceEdit.helpers({
  errorMessage: function(field) {
    return Session.get('sourceEditErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('sourceEditErrors')[field] ? 'has-error' : '';
  }
});

Template.sourceEdit.events({
  'submit form': function(e, template) {
    e.preventDefault();

    var currentSourceId = this._id;
    var projectId = this.projectId;

    var $body = $(e.target).find('[name=body]');
    var sourceProperties = {
      body: $body.val(),
    };

    var errors = {};
    if (! sourceProperties.body) {
      errors.body = "Please write some content";
      return Session.set('sourceEditErrors', errors);
    }

    Sources.update(currentSourceId, {$set: sourceProperties}, function(error) {
      if (error) {
        throwError(error.reason);
      } else {
        Router.go('projectPage', {_id: projectId});
      }
    });
  }
});

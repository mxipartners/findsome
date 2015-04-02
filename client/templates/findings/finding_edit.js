Template.findingEdit.created = function() {
  Session.set('findingEditErrors', {});
}

Template.findingEdit.helpers({
  errorMessage: function(field) {
    return Session.get('findingEditErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('findingEditErrors')[field] ? 'has-error' : '';
  }
});

Template.findingEdit.events({
  'submit form': function(e, template) {
    e.preventDefault();

    var currentFindingId = this._id;
    var projectId = this.projectId;

    var $body = $(e.target).find('[name=body]');
    var findingProperties = {
      body: $body.val(),
    };

    var errors = {};
    if (! findingProperties.body) {
      errors.body = "Please write some content";
      return Session.set('findingEditErrors', errors);
    }

    Findings.update(currentFindingId, {$set: findingProperties}, function(error) {
      if (error) {
        throwError(error.reason);
      } else {
        Router.go('projectPage', {_id: projectId});
      }
    });
  },

  'click .delete': function(e) {
    e.preventDefault();

    if (confirm("Delete this finding?")) {
      var projectId = this.projectId;
      Projects.update(projectId, {$inc: {findingsCount: -1}});
      Findings.remove(this._id);
      Router.go('projectPage', {_id: projectId});
    }
  }
});

Template.sourceEdit.helpers({
  hasNoFindings: function() {
    return Findings.find({sources: this._id}).count() == 0;
  }
});

Template.sourceEdit.events({
  'submit form': function(e, template) {
    e.preventDefault();

    var currentSourceId = this._id;
    var projectId = this.projectId;

    var $title = $(e.target).find('[name=title]');
    var $description = $(e.target).find('[name=description]');
    var sourceProperties = {
      title: $title.val(),
      description: $description.val()
    };

    Session.set('source_title', {});
    var errors = validateSource(sourceProperties);
    if (errors.title)
    {
      Session.set('source_title', errors);
      return false;
    };
    Sources.update(currentSourceId, {$set: sourceProperties}, function(error) {
      if (error) {
        throwError(error.reason);
      } else {
        Session.set('itemEdited', null);
        Router.go('projectPage', {_id: projectId});
      }
    });
  }
});

Template.deleteSource.events({
  'click .delete': function(e) {
    var projectId = this.projectId;
    Projects.update(projectId, {$inc: {sourcesCount: -1}});
    Sources.remove(this._id);
    // Make sure the backdrop is hidden before we go to the project page.
    $('#deleteSource').on('hidden.bs.modal', function() {
      Session.set('itemEdited', null);
      Router.go('projectPage', {_id: projectId});
    }).modal('hide');
  }
});

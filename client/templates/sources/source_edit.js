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
    Session.set('source_description', {});
    var errors = validateSource(sourceProperties);
    if (errors.title)
      Session.set('source_title', errors);
    if (errors.description)
      Session.set('source_description', errors);
    if (errors.title || errors.description)
      return false;

    Sources.update(currentSourceId, {$set: sourceProperties}, function(error) {
      if (error) {
        throwError(error.reason);
      } else {
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
      Router.go('projectPage', {_id: projectId});
    }).modal('hide');
  }
});

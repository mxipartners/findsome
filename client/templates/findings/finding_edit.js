Template.findingEdit.created = function() {
  Session.set('findingEditErrors', {});
}

Template.findingEdit.rendered = function() {
  $(".source-select").select2({
    placeholder: TAPi18n.__("Select sources")
  });
};

Template.findingEdit.helpers({
  errorMessage: function(field) {
    return Session.get('findingEditErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('findingEditErrors')[field] ? 'has-error' : '';
  },
  sources: function() {
    return Sources.find();
  },
  sourceIsSelected: function() {
    var finding = Template.parentData();
    return finding.sources.indexOf(this._id) > -1;
  },
  hasNoRisks: function() {
    return Risks.find({findings: this._id}).count() == 0;
  }
});

Template.findingEdit.events({
  'submit form': function(e, template) {
    e.preventDefault();

    var currentFindingId = this._id;
    var projectId = this.projectId;

    var $title = $(e.target).find('[name=title]');
    var $description = $(e.target).find('[name=description]');
    var $sources = $(e.target).find('[name=sources]');
    var findingProperties = {
      title: $title.val(),
      description: $description.val(),
      sources: $sources.val(),
    };

    Session.set('finding_title', {});
    Session.set('findingEditErrors', {});
    var errors = validateFinding(findingProperties);
    if (errors.title)
      Session.set('finding_title', errors);
    if (errors.sources)
      Session.set('findingEditErrors', errors);
    if (errors.title || errors.sources)
      return false;

    Findings.update(currentFindingId, {$set: findingProperties}, function(error) {
      if (error) {
        throwError(error.reason);
      } else {
        Session.set('itemEdited', null);
        Router.go('projectPage', {_id: projectId});
      }
    });
  }
});

Template.deleteFinding.helpers({
  translated_kind: function() {
    return TAPi18n.__(this.kind);
  }
});

Template.deleteFinding.events({
  'click .delete': function(e) {
    var projectId = this.projectId;
    Findings.remove(this._id);
    // Make sure the backdrop is hidden before we go to the project page.
    $('#deleteFinding').on('hidden.bs.modal', function() {
      Session.set('itemEdited', null);
      Router.go('projectPage', {_id: projectId});
    }).modal('hide');
  }
});

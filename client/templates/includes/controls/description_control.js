Template.descriptionControl.created = function() {
  Session.set(Template.currentData().control_id, {});
}

Template.descriptionControl.helpers({
  errorMessage: function(field) {
    return Session.get(Template.currentData().control_id)[field];
  },
  errorClass: function (field) {
    return !!Session.get(Template.currentData().control_id)[field] ? 'has-error' : '';
  }
});

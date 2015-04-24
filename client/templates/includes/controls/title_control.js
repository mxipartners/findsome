Template.titleControl.created = function() {
  Session.set(Template.currentData().control_id, {});
}

Template.titleControl.helpers({
  errorMessage: function(field) {
    return Session.get(Template.currentData().control_id)[field];
  },
  errorClass: function (field) {
    return !!Session.get(Template.currentData().control_id)[field] ? 'has-error' : '';
  }
});

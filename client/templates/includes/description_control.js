Template.descriptionControl.created = function() {
  Session.set('descriptionErrors', {});
}

Template.descriptionControl.helpers({
  errorMessage: function(field) {
    return Session.get('descriptionErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('descriptionErrors')[field] ? 'has-error' : '';
  }
});

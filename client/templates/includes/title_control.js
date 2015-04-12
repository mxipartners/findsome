Template.titleControl.created = function() {
  Session.set('titleErrors', {});
}

Template.titleControl.helpers({
  errorMessage: function(field) {
    return Session.get('titleErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('titleErrors')[field] ? 'has-error' : '';
  }
});

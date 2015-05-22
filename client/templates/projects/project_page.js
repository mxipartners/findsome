Template.projectPage.created = function() {
  Session.set('itemEdited', null);
};

Template.projectPage.helpers({
  itemEdited: function() {
    return Session.get('itemEdited');
  },
  kindIs: function(kind) {
    return this.kind === kind;
  }
});

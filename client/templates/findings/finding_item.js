Template.findingItem.events({
  'click .edit': function(e) {
    e.preventDefault();
    Session.set('itemEdited', this);
  }
});

Template.sourceItem.events({
  'click .edit': function(e) {
    e.preventDefault();
    Session.set('itemEdited', this);
  }
});

Template.projectPage.onCreated ->
  Session.set 'itemEdited', null

Template.projectPage.helpers
  item_is_edited: -> Session.get('itemEdited') == this._id

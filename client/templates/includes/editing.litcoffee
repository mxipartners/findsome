The session variable `itemEdited` keeps track of which item the user is
currently editing. It is set to the id of the item when the user starts
editing:

    @start_editing = (item) -> Session.set 'itemEdited', item._id

And set to `null` when the user stops editing the item:

    @stop_editing = -> Session.set 'itemEdited', null

To check whether a specific item is being edited, templates can use this
global helper:

    Template.registerHelper 'item_is_edited', ->
      Session.get('itemEdited') == this._id

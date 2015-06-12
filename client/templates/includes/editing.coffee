@start_editing = (item) -> Session.set 'itemEdited', item._id

@stop_editing = -> Session.set 'itemEdited', null

Template.registerHelper 'item_is_edited', ->
  Session.get('itemEdited') == this._id

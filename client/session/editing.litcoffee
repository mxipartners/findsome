The session variable `itemEdited` keeps track of which item the user is
currently editing. It is set to the `_id` of the item when the user starts
editing:

    @start_editing = (item) ->
      stop_submitting()
      Session.set 'itemEdited', item._id

And set to `null` when the user stops editing the item:

    @stop_editing = -> Session.set 'itemEdited', null

To check whether the item that is the current data context is being edited,
templates can use this global helper:

    Template.registerHelper 'item_is_edited', ->
      Session.get('itemEdited') == this._id


The session variable `kindSubmitting` keeps track of which kind of item the user
is currently submitting. It is set to the `kind` of the tab when the user
starts submitting:

    @start_submitting = (kind) ->
      stop_editing()
      Session.set 'kindSubmitting', kind

And set to `null` when the user stops submitting the item:

    @stop_submitting = -> Session.set 'kindSubmitting', null

To check which kind is currently being submitted, templates can use this global
helper:

    Template.registerHelper 'kind_submitting', (kind) ->
      Session.get('kindSubmitting') == kind

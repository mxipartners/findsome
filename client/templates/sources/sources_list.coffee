Template.sourcesList.helpers
  sources: -> Sources.find {}, {sort: {position: 1}}
  submitting: -> Session.get('kindSubmitting') == 'source' or Sources.find().count() == 0

Template.sourcesList.onRendered ->
  options = _.extend drag_and_drop_options,
    update: (event, ui) ->
      index = 0
      _.each $(".item"), (item) ->
        Sources.update {_id: item.id}, {$set: {position: index++}}
  this.$(".sortable").sortable(options).disableSelection()

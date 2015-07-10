Template.measuresList.helpers
  measures: -> Measures.find {}, {sort: {position: 1}}
  has_risks: -> Risks.find().count() > 0
  submitting: -> Session.get('kindSubmitting') == 'measure' or Measures.find().count() == 0

Template.measuresList.onRendered ->
  options = _.extend drag_and_drop_options,
    update: (event, ui) ->
      index = 0
      _.each $(".item"), (item) ->
        Measures.update {_id: item.id}, {$set: {position: index++}}
  this.$(".sortable").sortable(options).disableSelection()

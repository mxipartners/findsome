Template.findingsList.helpers
  findings: -> Findings.find {}, {sort: {position: 1}}
  has_sources: -> Sources.find().count() > 0
  submitting: -> Session.get('kindSubmitting') == 'finding' or Findings.find().count() == 0

Template.findingsList.onRendered ->
  options = _.extend drag_and_drop_options,
    update: (event, ui) ->
      index = 0
      _.each $(".item"), (item) ->
        Findings.update {_id: item.id}, {$set: {position: index++}}
  this.$(".sortable").sortable(options).disableSelection()

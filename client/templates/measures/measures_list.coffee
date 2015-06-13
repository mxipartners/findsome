Template.measuresList.helpers
  measures: -> Measures.find {projectId: this._id}, {sort: {position: 1}}
  has_risks: -> Risks.find({projectId: this._id}).count() > 0

Template.measuresList.onRendered ->
  options = _.extend drag_and_drop_options,
    update: (event, ui) ->
      index = 0
      _.each $(".item"), (item) ->
        Measures.update {_id: item.id}, {$set: {position: index++}}
  this.$(".sortable").sortable(options).disableSelection()

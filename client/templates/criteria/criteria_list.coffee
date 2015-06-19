Template.criteriaList.helpers
  criteria: -> Criteria.find {checklistId: this._id}, {sort: {position: 1}}

Template.criteriaList.onRendered ->
  options = _.extend drag_and_drop_options,
    update: (event, ui) ->
      index = 0
      _.each $(".item"), (item) ->
        Criteria.update {_id: item.id}, {$set: {position: index++}}
  this.$(".sortable").sortable(options).disableSelection()

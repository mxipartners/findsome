Template.findingsList.helpers
  findings: -> Findings.find {projectId: this._id}, {sort: {position: 1}}
  has_sources: -> Sources.find({projectId: this._id}).count() > 0

Template.findingsList.onRendered ->
  options = _.extend drag_and_drop_options,
    update: (event, ui) ->
      index = 0
      _.each $(".item"), (item) ->
        Findings.update {_id: item.id}, {$set: {position: index++}}
  this.$(".sortable").sortable(options).disableSelection()

Template.risksList.helpers
  risks: -> Risks.find {projectId: this._id}, {sort: {position: 1}}
  has_findings: -> Findings.find({projectId: this._id}).count() > 0

Template.risksList.onRendered ->
  options = _.extend drag_and_drop_options,
    update: (event, ui) ->
      index = 0
      _.each $(".item"), (item) ->
        Risks.update {_id: item.id}, {$set: {position: index++}}
  this.$(".sortable").sortable(options).disableSelection()

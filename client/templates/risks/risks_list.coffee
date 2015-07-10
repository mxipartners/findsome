Template.risksList.helpers
  risks: -> Risks.find {}, {sort: {position: 1}}
  has_findings: -> Findings.find().count() > 0
  submitting: -> Session.get('kindSubmitting') == 'risk' or Risks.find().count() == 0

Template.risksList.onRendered ->
  options = _.extend drag_and_drop_options,
    update: (event, ui) ->
      index = 0
      _.each $(".item"), (item) ->
        Risks.update {_id: item.id}, {$set: {position: index++}}
  this.$(".sortable").sortable(options).disableSelection()

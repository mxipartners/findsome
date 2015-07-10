Template.checklistTabs.onCreated ->
  Session.setDefault 'currentChecklistTab', 'criterium'

Template.checklistTabs.onRendered ->
  current = this.$('a[href="#' + Session.get('currentChecklistTab') + '"]')
  current.tab 'show'

Template.checklistTabs.events
  'shown.bs.tab': (e) ->
    Session.set 'currentChecklistTab', e.target.href.split('#')[1]
  'click .add-kind': (e) ->
    start_submitting Session.get 'currentChecklistTab'

Template.checklistTabs.helpers
  criteria_count: -> Criteria.find().count()
  translated_kind: -> TAPi18n.__ Session.get 'currentChecklistTab'

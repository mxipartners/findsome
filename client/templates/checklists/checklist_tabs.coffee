Template.checklistTabs.onCreated ->
  Session.setDefault 'currentChecklistTab', 'criteria'

Template.checklistTabs.onRendered ->
  current = this.$('a[href="#' + Session.get('currentChecklistTab') + '"]')
  current.tab 'show'

Template.checklistTabs.events
  'shown.bs.tab': (e) ->
    Session.set 'currentChecklistTab', e.target.href.split('#')[1]

Template.checklistTabs.helpers
  criteria_count: -> Criteria.find({checklistId: this._id}).count()

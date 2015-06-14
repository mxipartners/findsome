Template.projectPage.onCreated -> stop_editing()

Template.projectPage.helpers
  show_tip: -> Meteor.user() and (Meteor.user().show_tip == undefined)

Template.projectPage.events
  'click a': (e) ->
    Meteor.users.update Meteor.user()._id, {$set: {'show_tip': false}}, (error) ->
      if error
        throwError error.reason

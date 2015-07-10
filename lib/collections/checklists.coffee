@Checklists = new Mongo.Collection 'checklists'

Checklists.allow
  update: (userId, checklist) -> isChecklistOwner userId, checklist
  remove: (userId, checklist) -> isChecklistOwner userId, checklist

Checklists.deny
  update: (userId, checklist, fieldNames) ->
    # may only edit the following fields:
    _.without(fieldNames, 'title', 'description', 'owners').length > 0

Checklists.deny
  update: (userId, checklist, fieldNames, modifier) ->
      if modifier.$set == undefined
        return ""
      errors = validateChecklist modifier.$set
      errors.title or errors.owners

Meteor.methods
  checklistInsert: (checklistAttributes) ->
    check Meteor.userId(), String
    validateChecklist checklistAttributes
    user = Meteor.user()
    checklist = _.extend checklistAttributes,
      userId: user._id
      submitted: new Date()
      kind: 'checklist'
    checklistId = Checklists.insert checklist
    text = user.username + ' added you as checklist owner to ' + checklist.title
    createNotification(owner, user._id, checklistId, text) for owner in checklist.owners
    return {_id: checklistId}

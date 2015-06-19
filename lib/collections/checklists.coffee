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

@validateChecklist = (checklist) ->
  errors = {}
  if not checklist.title
    errors.title = TAPi18n.__ "Please provide a title"
  if not checklist.owners
    errors.owners = TAPi18n.__ "Please select at least one checklist owner"
  return errors

Meteor.methods
  checklistInsert: (checklistAttributes) ->
    check Meteor.userId(), String
    check checklistAttributes,
      title: String
      description: String
      owners: Array
    errors = validateChecklist checklistAttributes
    if errors.title
      throw new Meteor.Error('invalid-checklist', "You must set a title for your checklist")
    if errors.owners
      throw new Meteor.Error('invalid-checklist', "You must select as least one checklist owner")
    user = Meteor.user()
    checklist = _.extend checklistAttributes,
      userId: user._id
      submitted: new Date()
      kind: 'checklist'
    checklistId = Checklists.insert checklist
    text = user.username + ' added you as checklist owner to ' + checklist.title
    createNotification(owner, user._id, checklistId, text) for owner in checklist.owners
    return {_id: checklistId}

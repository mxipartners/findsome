@validateChecklist = (checklist) ->
  check checklist, Match.ObjectIncluding
    owners: [String]
  errors = validateItem checklist
  if checklist.owners.length == 0
    if Meteor.isServer
      throw new Meteor.Error('invalid-checklist',
                             'You must select as least one checklist owner')
    else
      errors.owners = TAPi18n.__ "Please select at least one checklist owner"
  return errors

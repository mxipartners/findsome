@validateChecklist = (checklist) ->
  check checklist, Match.ObjectIncluding
    owners: [String]
  errors = validateItem checklist
  if checklist.owners.length == 0
    errors.owners = TAPi18n.__ "Please select at least one checklist owner"
  return errors

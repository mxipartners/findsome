@validateChecklist = (checklist) ->
  errors = validateItem checklist
  if not checklist.owners
    errors.owners = TAPi18n.__ "Please select at least one checklist owner"
  return errors

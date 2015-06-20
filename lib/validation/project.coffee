@validateProject = (project) ->
  errors = validateItem project
  if not project.members
    errors.members = TAPi18n.__ "Please select at least one project member"
  return errors

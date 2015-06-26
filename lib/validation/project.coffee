@validateProject = (project) ->
  check project, Match.ObjectIncluding
    members: [String]
    checklists: [String]
  errors = validateItem project
  if project.members.length == 0
    errors.members = TAPi18n.__ "Please select at least one project member"
  return errors

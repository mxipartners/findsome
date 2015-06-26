@validateFinding = (finding) ->
  check finding, Match.ObjectIncluding
    sources: [String]
  errors = validateItem finding
  if finding.sources.length == 0
    errors.sources = TAPi18n.__ "Please select one or more sources for the finding"
  return errors

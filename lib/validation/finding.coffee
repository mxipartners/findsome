@validateFinding = (finding) ->
  errors = validateItem finding
  if not finding.sources
    errors.sources = TAPi18n.__ "Please select one or more sources for the finding"
  return errors

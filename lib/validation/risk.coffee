@validateRisk = (risk) ->
  errors = validateItem risk
  if not risk.findings
    errors.findings = TAPi18n.__ "Please select one or more findings for the risk"
  return errors

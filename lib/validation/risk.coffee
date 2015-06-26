@validateRisk = (risk) ->
  check risk, Match.ObjectIncluding
    findings: [String]
  errors = validateItem risk
  if risk.findings.length == 0
    errors.findings = TAPi18n.__ "Please select one or more findings for the risk"
  return errors

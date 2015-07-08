@validateRisk = (risk) ->
  check risk, Match.ObjectIncluding
    findings: [String]
  errors = validateItem risk
  if risk.findings.length == 0
    if Meteor.isServer
      throw new Meteor.Error('invalid-risk', 'You must add one or more findings to the risk')
    else
      errors.findings = TAPi18n.__ "Please select one or more findings for the risk"
  return errors

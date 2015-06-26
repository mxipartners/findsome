@validateMeasure = (measure) ->
  check measure, Match.ObjectIncluding
    risks: [String]
  errors = validateItem measure
  if measure.risks.length == 0
    errors.risks = TAPi18n.__ "Please select one or more risks that the measure addresses"
  return errors

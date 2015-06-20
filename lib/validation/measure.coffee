@validateMeasure = (measure) ->
  errors = validateItem measure
  if not measure.risks
    errors.risks = TAPi18n.__ "Please select one or more risks that the measure addresses"
  return errors

@validateMeasure = (measure) ->
  check measure, Match.ObjectIncluding
    risks: [String]
  errors = validateItem measure
  if measure.risks.length == 0
    if Meteor.isServer
      throw new Meteor.Error('invalid-measure', 'You must add one or more risks to the measure')
    else
      errors.risks = TAPi18n.__ "Please select one or more risks that the measure addresses"
  return errors

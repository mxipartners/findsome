@validateFinding = (finding) ->
  check finding, Match.ObjectIncluding
    sources: [String]
    criteria: [String]
  errors = validateItem finding
  if finding.sources.length == 0
    if Meteor.isServer
      throw new Meteor.Error('invalid-finding', 'You must add one or more sources to the finding')
    else
      errors.sources = TAPi18n.__ "Please select one or more sources for the finding"
  return errors

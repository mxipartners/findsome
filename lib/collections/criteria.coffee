@Criteria = new Mongo.Collection 'criteria'

Criteria.allow
  update: (userId, criterium) -> ownsCriterium userId, criterium
  remove: (userId, criterium) -> ownsCriterium userId, criterium

Criteria.deny
  remove: (userId, criterium) -> Findings.find({criteria: criterium._id}).count() > 0

@validateCriterium = (criterium) ->
  errors = {}
  if not criterium.title
    errors.title = TAPi18n.__ "Please provide a title"
  return errors

Meteor.methods
  criteriumInsert: (criteriumAttributes) ->
    check this.userId, String
    check criteriumAttributes,
      checklistId: String
      title: String
      description: String
    user = Meteor.user();
    checklist = Checklists.findOne criteriumAttributes.checklistId
    if not checklist
      throw new Meteor.Error('invalid-criterium', 'You must add a criterium to a checklist')
    criterium = _.extend criteriumAttributes,
      userId: user._id
      submitted: new Date()
      position: Criteria.find({checklistId: criteriumAttributes.checklistId}).count()
      kind: 'criterium'
    # Create the criterium, save the id
    criterium._id = Criteria.insert criterium
    # Now create a notification, informing the checklist owners a criterium has been added
    text = user.username + ' added criterium ' + criterium.title + ' to ' + checklist.title
    createNotification(owner, user._id, criterium.checklistId, text) for owner in checklist.owners
    return criterium._id

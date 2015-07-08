@Criteria = new Mongo.Collection 'criteria'

Criteria.allow
  update: (userId, criterium) -> ownsCriterium userId, criterium
  remove: (userId, criterium) -> ownsCriterium userId, criterium

Criteria.deny
  remove: (userId, criterium) -> Findings.find({criteria: criterium._id}).count() > 0

Meteor.methods
  criteriumInsert: (criteriumAttributes) ->
    check this.userId, String
    user = Meteor.user()
    validateCriterium criteriumAttributes
    criterium = _.extend criteriumAttributes,
      userId: user._id
      submitted: new Date()
      position: 0
      kind: 'criterium'
    # Update the positions of the existing criteria
    Criteria.update({_id: c._id}, {$set: {position: c.position+1}}) for c in Criteria.find({checklistId: criterium.checklistId}).fetch()
    # Create the criterium, save the id
    criterium._id = Criteria.insert criterium
    # Now create a notification, informing the checklist owners a criterium has been added
    checklist = Checklists.findOne criterium.checklistId
    text = user.username + ' added criterium ' + criterium.title + ' to ' + checklist.title
    createNotification(owner, user._id, criterium.checklistId, text) for owner in checklist.owners
    return criterium._id

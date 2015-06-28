Template.errors.helpers
  errors: -> Errors.find()

Template.error.onRendered ->
  error = this.data
  removeErrors = -> Errors.remove error._id
  Meteor.setTimeout removeErrors, 5000

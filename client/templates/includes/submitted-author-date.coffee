Template.submittedAuthorDate.helpers
  submitted_date: -> this.submitted.toString()
  author_name: -> Meteor.users.findOne(this.userId).username

Meteor.users.allow
  update: (userId, user) -> user._id == userId

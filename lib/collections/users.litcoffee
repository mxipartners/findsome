Allow users to update their own user data. This is needed to be able to remember
whether the user has seen the tip about drag and drop.

    Meteor.users.allow
      update: (userId, user) -> user._id == userId

Sources = new Mongo.Collection('sources');

Sources.allow({
  update: function(userId, source) { return ownsDocument(userId, source); },
  remove: function(userId, source) { return ownsDocument(userId, source); },
});

Meteor.methods({
  sourceInsert: function(sourceAttributes) {
    check(this.userId, String);
    check(sourceAttributes, {
      projectId: String,
      body: String
    });
    var user = Meteor.user();
    var project = Projects.findOne(sourceAttributes.projectId);
    if (!project)
      throw new Meteor.Error('invalid-source', 'You must add a source to a project');
    source = _.extend(sourceAttributes, {
      userId: user._id,
      author: user.username,
      submitted: new Date(),
      kind: 'source'
    });
    // update the project with the number of sources
    Projects.update(source.projectId, {$inc: {sourcesCount: 1}});
    // create the source, save the id
    source._id = Sources.insert(source);
    // now create a notification, informing the user that there's been a source
    createNotification(source);
    return source._id;
  }
});

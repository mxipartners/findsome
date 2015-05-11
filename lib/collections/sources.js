Sources = new Mongo.Collection('sources');

Sources.allow({
  update: function(userId, source) { return ownsDocument(userId, source); },
  remove: function(userId, source) { return ownsDocument(userId, source); }
});

Sources.deny({
  remove: function(userId, source) {
    Findings.find({sources: source._id}).count() > 0;
  }
})

validateSource = function(source) {
  var errors = {};

  if (!source.title)
    errors.title = "Please give the source a title";

  if (!source.description)
    errors.description =  "Please give the source a description";

  return errors;
}

Meteor.methods({
  sourceInsert: function(sourceAttributes) {
    check(this.userId, String);
    check(sourceAttributes, {
      projectId: String,
      title: String,
      description: String
    });
    var user = Meteor.user();
    var project = Projects.findOne(sourceAttributes.projectId);
    if (!project)
      throw new Meteor.Error('invalid-source', 'You must add a source to a project');
    source = _.extend(sourceAttributes, {
      userId: user._id,
      author: user.username,
      submitted: new Date(),
      kind: 'source',
    });
    // update the project with the number of sources
    Projects.update(source.projectId, {$inc: {sourcesCount: 1}});
    // create the source, save the id
    source._id = Sources.insert(source);
    // now create a notification, informing the project members a source has been added
    for (i = 0; i < project.members.length; i++)
    {
      createNotification(project.members[i], user._id, source.projectId,
        user.username + ' added source ' + source.title + ' to ' + project.title);
    };
    return source._id;
  }
});

Projects = new Mongo.Collection('projects');

Projects.allow({
  update: function(userId, project) { return ownsDocument(userId, project); },
  remove: function(userId, project) { return ownsDocument(userId, project); },
});

Projects.deny({
  update: function(userId, project, fieldNames) {
    // may only edit the following fields:
    return (_.without(fieldNames, 'title', 'description',
      'findingsCount', 'sourcesCount', 'members').length > 0);
  }
});

Projects.deny({
  update: function(userId, project, fieldNames, modifier) {
      if (modifier.$set === undefined) {
        return "";
      };
      var errors = validateProject(modifier.$set);
      return errors.title || errors.description;
  }
});

validateProject = function (project) {
  var errors = {};

  if (!project.title)
    errors.title = "Please give the project a title";

  if (!project.description)
    errors.description =  "Please give the project a brief description";

  return errors;
}

Meteor.methods({
  projectInsert: function(projectAttributes) {
    check(Meteor.userId(), String);
    check(projectAttributes, {
      title: String,
      description: String,
      members: Array
    });

    var errors = validateProject(projectAttributes);
    if (errors.title || errors.description)
      throw new Meteor.Error('invalid-project', "You must set a title and description for your project");

    var projectWithSameTitle = Projects.findOne({title: projectAttributes.title});
    if (projectWithSameTitle) {
      return {
        projectExists: true,
        _id: projectWithSameTitle._id
      }
    }
    var user = Meteor.user();
    var project = _.extend(projectAttributes, {
      userId: user._id,
      author: user.username,
      submitted: new Date(),
      risksCount: 0,
      findingsCount: 0,
      sourcesCount: 0,
      kind: 'project'
    });
    var projectId = Projects.insert(project);
    for (i = 0; i < project.members.length; i++)
    {
      createNotification(project.members[i], user._id, projectId,
        user.username + ' added you as project member to ' + project.title);
    };
    return {
      _id: projectId
    };
  }
});

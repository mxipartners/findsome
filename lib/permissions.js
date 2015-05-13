isProjectMember = function(userId, project) {
  return project.members.indexOf(userId) > -1;
};

ownsProjectItem = function(userId, item) {
  return isProjectMember(userId, Projects.findOne(item.projectId));
};

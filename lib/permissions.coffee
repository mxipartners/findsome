@isProjectMember = (userId, project) -> userId in project.members

@ownsProjectItem = (userId, item) ->
  isProjectMember userId, Projects.findOne(item.projectId)

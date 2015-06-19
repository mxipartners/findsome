@isProjectMember = (userId, project) -> userId in project.members

@ownsProjectItem = (userId, item) ->
  isProjectMember userId, Projects.findOne(item.projectId)

@isChecklistOwner = (userId, checklist) -> userId in checklist.owners

@ownsCriterium = (userId, item) ->
  isChecklistOwner userId, Checklists.findOne(item.checklistId)

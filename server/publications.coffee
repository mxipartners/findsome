Meteor.publish 'projects', ->
  Projects.find {members: this.userId}

Meteor.publish 'measures', (projectId) ->
  check projectId, String
  Measures.find {projectId: projectId}

Meteor.publish 'risks', (projectId) ->
  check projectId, String
  Risks.find {projectId: projectId}

Meteor.publish 'findings', (projectId) ->
  check projectId, String
  Findings.find {projectId: projectId}

Meteor.publish 'sources', (projectId) ->
  check projectId, String
  Sources.find {projectId: projectId}

Meteor.publish 'checklists', ->
  Checklists.find {owners: this.userId}

Meteor.publish 'all_criteria', ->
  Criteria.find()

Meteor.publish 'criteria', (checklistId) ->
  check checklistId, String
  Criteria.find {checklistId: checklistId}

Meteor.publish 'notifications', ->
  Notifications.find {userId: this.userId}

Meteor.publish 'usernames', ->
  Meteor.users.find {}, {fields: {'username': 1, '_id': 1, 'show_tip': 1}}

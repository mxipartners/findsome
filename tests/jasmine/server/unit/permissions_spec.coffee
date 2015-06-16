describe 'A user, when added to a project', ->

  project = {members: ['id']}

  it 'is a project member', ->
    expect(isProjectMember('id', project)).toBe true

  it 'owns the items in the project', ->
    spyOn(Projects, 'findOne').and.returnValue(project)
    expect(ownsProjectItem('id', {projectId: 'projectId'})).toBe true

describe 'A user, when not added to a project', ->

  project = {members: ['another id']}

  it 'is not a project member', ->
    expect(isProjectMember('id', project)).toBe false

  it "doesn't own the items in the project", ->
    spyOn(Projects, 'findOne').and.returnValue(project)
    expect(ownsProjectItem('id', {projectId: 'projectId'})).toBe false

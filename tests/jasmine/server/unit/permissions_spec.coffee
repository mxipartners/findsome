describe 'A user, when added to a project', ->

  project = {members: ['id']}

  it 'owns a project', ->
    expect(isProjectMember('id', project)).toBe true

  it 'owns the items in the project', ->
    spyOn(Projects, 'findOne').and.returnValue(project)
    expect(ownsProjectItem('id', {projectId: 'projectId'})).toBe true


describe 'A user, when not added to a project', ->

  project = {members: ['another id']}

  it 'is not an owner', ->
    expect(isProjectMember('id', project)).toBe false

  it "doesn't own items in the project", ->
    spyOn(Projects, 'findOne').and.returnValue(project)
    expect(ownsProjectItem('id', {projectId: 'projectId'})).toBe false


describe 'A user, when added to a checklist', ->

  checklist = {owners: ['id']}

  it 'is an owner', ->
    expect(isChecklistOwner('id', checklist)).toBe true

  it 'owns the items in the checklist', ->
    spyOn(Checklists, 'findOne').and.returnValue(checklist)
    expect(ownsCriterium('id', {checklistId: 'checklistId'})).toBe true


describe 'A user, when not added to a checklist', ->

  checklist = {owners: ['another id']}

  it 'is not a checklist owner', ->
    expect(isChecklistOwner('id', checklist)).toBe false

  it "doesn't own the items in the checklist", ->
    spyOn(Checklists, 'findOne').and.returnValue(checklist)
    expect(ownsCriterium('id', {checklistId: 'checklistId'})).toBe false

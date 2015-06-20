title_error =
  title: jasmine.any(String)


describe 'An item', ->

  it 'is valid when it has a title', ->
    expect(validateItem({title: 'Title'})).toEqual {}

  it 'is invalid when it has no title', ->
    expect(validateItem({title: ''})).toEqual title_error


describe 'A project', ->

  beforeEach ->
    this.project =
      title: 'Title'
      members: ['Dummy user']

  it 'is valid when it has a title and at least one project member', ->
    expect(validateProject(this.project)).toEqual {}

  it 'is invalid when it has no title', ->
    this.project.title = ''
    expect(validateProject(this.project)).toEqual title_error

  it 'is invalid when it has no members', ->
    this.project.members = null
    expect(validateProject(this.project)).toEqual
      members: jasmine.any(String)

  it 'is invalid when it has no title and no members', ->
    expect(validateProject({})).toEqual
      title: jasmine.any(String)
      members: jasmine.any(String)


describe 'A source', ->

  it 'is valid when it has a title', ->
    expect(validateSource({title: 'Title'})).toEqual {}

  it 'is invalid when it has no title', ->
    expect(validateSource({title: ''})).toEqual title_error


describe 'A finding', ->

  beforeEach ->
    this.finding =
      title: 'Title'
      sources: ['Dummy source']

  it 'is valid when it has a title and at least one source', ->
    expect(validateFinding(this.finding)).toEqual {}

  it 'is invalid when it has no title', ->
    this.finding.title = ''
    expect(validateFinding(this.finding)).toEqual title_error

  it 'is invalid when it has no sources', ->
    this.finding.sources = null
    expect(validateFinding(this.finding)).toEqual
      sources: jasmine.any(String)

  it 'is invalid when it has no title and no sources', ->
    expect(validateFinding({})).toEqual
      title: jasmine.any(String)
      sources: jasmine.any(String)


describe 'A risk', ->

  beforeEach ->
    this.risk =
      title: 'Title'
      findings: ['Dummy finding']

  it 'is valid when it has a title and at least one finding', ->
    expect(validateRisk(this.risk)).toEqual {}

  it 'is invalid when it has no title', ->
    this.risk.title = ''
    expect(validateRisk(this.risk)).toEqual title_error

  it 'is invalid when it has no findings', ->
    this.risk.findings = null
    expect(validateRisk(this.risk)).toEqual
      findings: jasmine.any(String)

  it 'is invalid when it has no title and no findings', ->
    expect(validateRisk({})).toEqual
      title: jasmine.any(String)
      findings: jasmine.any(String)


describe 'A measure', ->

  beforeEach ->
    this.measure =
      title: 'Title'
      risks: ['Dummy risk']

  it 'is valid when it has a title and at least one risk', ->
    expect(validateMeasure(this.measure)).toEqual {}

  it 'is invalid when it has no title', ->
    this.measure.title = ''
    expect(validateMeasure(this.measure)).toEqual title_error

  it 'is invalid when it has no risks', ->
    this.measure.risks = null
    expect(validateMeasure(this.measure)).toEqual
      risks: jasmine.any(String)

  it 'is invalid when it has no title and no risks', ->
    expect(validateMeasure({})).toEqual
      title: jasmine.any(String)
      risks: jasmine.any(String)


describe 'A checklist', ->

  beforeEach ->
    this.checklist =
      title: 'Title'
      owners: ['Dummy user']

  it 'is valid when it has a title and at least one owner', ->
    expect(validateChecklist(this.checklist)).toEqual {}

  it 'is invalid when it has no title', ->
    this.checklist.title = ''
    expect(validateChecklist(this.checklist)).toEqual title_error

  it 'is invalid when it has no owners', ->
    this.checklist.owners = null
    expect(validateChecklist(this.checklist)).toEqual
      owners: jasmine.any(String)

  it 'is invalid when it has no title and no owners', ->
    expect(validateChecklist({})).toEqual
      title: jasmine.any(String)
      owners: jasmine.any(String)


describe 'A criterium', ->

  it 'is valid when it has a title', ->
    expect(validateCriterium({title: 'Title'})).toEqual {}

  it 'is invalid when it has no title', ->
    expect(validateCriterium({title: ''})).toEqual title_error

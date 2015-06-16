describe 'The edited item', ->
  it 'is undefined by default', ->
    expect(Session.get('itemEdited')).toEqual undefined
  it 'can be set', ->
    start_editing {_id: 'item'}
    expect(Session.get('itemEdited')).toEqual 'item'
  it 'is null after stopping the editing', ->
    start_editing {_id: 'item'}
    stop_editing()
    expect(Session.get('itemEdited')).toEqual null

describe 'The edited item', ->
  it 'can be set', ->
    start_editing {_id: 'item'}
    expect(Session.get('itemEdited')).toEqual 'item'
  it 'is null after stopping the editing', ->
    start_editing {_id: 'item'}
    stop_editing()
    expect(Session.get('itemEdited')).toEqual null
  it 'is null when the user starts submitting an item', ->
    start_editing {_id: 'item'}
    start_submitting 'source'
    expect(Session.get('itemEdited')).toEqual null
    
describe 'The submitted kind', ->
  it 'can be set', ->
    start_submitting 'source'
    expect(Session.get('kindSubmitting')).toEqual 'source'
  it 'is null after stopping the submitting', ->
    start_submitting 'source'
    stop_submitting()
    expect(Session.get('kindSubmitting')).toEqual null
  it 'is null when the user starts editing an item', ->
    start_submitting 'source'
    start_editing {_id: 'item'}
    expect(Session.get('kindSubmitting')).toEqual null

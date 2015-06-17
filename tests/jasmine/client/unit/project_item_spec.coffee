describe 'The list of usernames', ->
  it 'is sorted', ->
    spyOn(Meteor.users, 'find')
    Template.projectEdit.__helpers.get('usernames')()
    expect(Meteor.users.find).toHaveBeenCalledWith({}, {sort: {username: 1}})

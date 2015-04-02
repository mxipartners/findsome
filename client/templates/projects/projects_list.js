Template.projectsList.helpers({
  projects: function() {
    return Projects.find({}, {sort: {submitted: -1}});
  }
});


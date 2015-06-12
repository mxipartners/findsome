Template.projectsList.helpers
  projects: -> Projects.find {}, {sort: {submitted: -1}}

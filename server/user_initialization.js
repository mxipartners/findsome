Accounts.onCreateUser(function(options, user) {
  tutorial = {
    title: "Welcome to Findsome, " + user.username + "!",
    description: "Findsome aims to help you do investigations, intakes, and " +
      "due dilligence projects. It allows you to register sources, findings, " +
      "risks, and mitigating measures. And it helps you to keep track of the " +
      "relationships between them. This is an example project. Feel free to " +
      "add some sources, findings, risks, and measures to it and delete the " +
      "project when you're done with it.",
    members: [user._id],
    userId: user._id,
    author: user.username,
    submitted: new Date(),
    kind: 'project'
  };
  Projects.insert(tutorial);
  return user;
});

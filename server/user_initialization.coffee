Accounts.onCreateUser (options, user) ->
  tutorial =
    title: "Welcome to Findsome, #{user.username}!"
    description: "Findsome aims to help you do investigations, intakes, and
      due dilligence projects. It allows you to register sources, findings,
      risks, and mitigating measures. And it helps you to keep track of the
      relationships between them. This is an example project. Feel free to
      edit the sources, findings, risks, and measures. Of course you can delete
      the project when you're done with it."
    members: [user._id]
    userId: user._id
    submitted: new Date
    kind: 'project'
  projectId = Projects.insert tutorial
  source1 =
    title: "Interview with project lead"
    description: "This is an example of a source. In this case an interview
      with a project leader. Some of the findings under the findings tab are
      based on this source."
    projectId: projectId
    userId: user._id
    position: 0
    submitted: new Date
    kind: 'source'
  source1Id = Sources.insert source1
  source2 =
    title: "Software architecture description"
    description: "An example source, in this case a software architecture
      decription, or SAD for short. Some of the findings are based on this
      source."
    projectId: projectId
    userId: user._id
    position: 1
    submitted: new Date
    kind: 'source'
  source2Id = Sources.insert source2
  source3 =
    title: "Unit tests"
    description: "The source code comes with unit tests."
    projectId: projectId
    userId: user._id
    position: 2
    submitted: new Date
    kind: 'source'
  source3Id = Sources.insert source3
  finding1 =
    title: "SAD is outdated"
    description: "This is an example of a finding. The software architecture
      document is outdated. We base this finding both on the document itself as
      well as on the interview with the project lead."
    projectId: projectId
    userId: user._id
    position: 0
    submitted: new Date
    kind: 'finding'
    sources: [source1Id, source2Id]
  finding1Id = Findings.insert finding1
  finding2 =
    title: "No automated tests"
    description: "This is an example of a finding. The project under
      investigation has developed no automated tests. We base this finding on
      the interview with the project lead."
    projectId: projectId
    userId: user._id
    position: 1
    submitted: new Date
    kind: 'finding'
    sources: [source1Id]
  finding2Id = Findings.insert finding2
  risk1 =
    title: "Regression bugs"
    description: "This is an example of a risk. Since there are no automated
      tests, there is a risk that changes to the software will cause bugs."
    projectId: projectId
    userId: user._id
    position: 0
    submitted: new Date
    kind: 'risk'
    findings: [finding2Id]
  risk1Id = Risks.insert risk1
  measure1 =
    title: "Create automated regression test"
    description: "This is an example of a mitigating measure. Since there are
      no automated tests, there is a risk that changes to the software will
      cause bugs. Creating an automated regression test can mitigate this risk."
    projectId: projectId
    userId: user._id
    position: 0
    submitted: new Date
    kind: 'measure'
    risks: [risk1Id]
  Measures.insert measure1
  return user

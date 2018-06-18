atom.commands.add 'atom-workspace', 'atom-ide-terminal:new-project-terminal', ->
  projectDir = atom.project.rootDirectories[0].path
  atom.packages.serviceHub.consume 'nuclide-terminal', '*', (t)->
    t.open(cwd: projectDir)
 

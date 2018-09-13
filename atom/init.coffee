
atom.commands.add 'atom-workspace', 'atom-ide-terminal:new-project-terminal', ->
  projectDir = atom.project.rootDirectories[0].path
  atom.packages.serviceHub.consume 'nuclide-terminal', '*', (t)->
    t.open(cwd: projectDir)


atom.commands.add '.terminal-pane', 'atom-ide-terminal:move-to-start-of-line', ->
  terminal = atom.workspace.getActivePane().activeItem
  if terminal.getElement() is this # wew
    terminal._onInput '\x1B[1~' # home

atom.commands.add '.terminal-pane', 'atom-ide-terminal:move-to-end-of-line', ->
  terminal = atom.workspace.getActivePane().activeItem
  if terminal.getElement() is this
    terminal._onInput '\x1B[4~' # end

# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

# atom.workspaceView.command 'custom:copyline', ->
#   editor = atom.workspace.getActiveEditor()
#   if not editor.getSelectedText()
#     cursor = editor.getCursor()
#     originalPosition = cursor.getScreenPosition()
#     editor.selectLine()
#     editor.copySelectedText()
#     cursor.setScreenPosition(originalPosition)
#   else
#     editor.copySelectedText()
path = require 'path'
fs = require 'fs'



projectPath = atom.project.getPaths()

buildfileExists = true
platformIOExists = true
makefileExists = true

checkbuild = ->
  buildfileExists = true
  platformIOExists = true
  makefileExists = true

  # Check for Atom Build file
  try
    dir1 = fs.statSync (projectPath+"/.atom-build.json")
    if dir1.isDirectory()
      buildfileExists = false
  catch
    buildfileExists = false

  # Check for PlatformIO file
  try
    dir1 = fs.statSync (projectPath+"/platformio.ini")
    if dir1.isDirectory()
      platformIOExists = false
  catch
    platformIOExists = false

  # Check for Makefile
  try
    dir1 = fs.statSync (projectPath+"/makefile")
    if dir1.isDirectory()
      makefileExists = false
  catch
    makefileExists = false

getFileType = ->
  try
    fileName = atom.workspace.getActiveTextEditor().getTitle()
  catch
    fileName = ""
  seperate = fileName.split "."
  filetype = seperate[seperate.length-1]
  if seperate.length==1
    filetype = ""
  return filetype


atom.commands.add 'atom-workspace',
  'custom:build-command': ->
    checkbuild()
    type = getFileType()
    editorElement = atom.views.getView(atom.workspace.getActiveTextEditor())
    if type == "md"
      try
        atom.commands.dispatch(editorElement, 'markdown-preview:toggle')
    else if buildfileExists
      try
        atom.commands.dispatch(editorElement, 'build:trigger')
    else if platformIOExists
      try
        atom.commands.dispatch(editorElement, 'platomformio:build')
    else if makefileExists
      try
        atom.commands.dispatch(editorElement, 'build:trigger')
    else
      try
        atom.commands.dispatch(editorElement, 'script:run')

  'custom:extra-build-command': ->
    checkbuild()
    editorElement = atom.views.getView(atom.workspace.getActiveTextEditor())
    if buildfileExists
      try
        atom.commands.dispatch(editorElement, 'build:select-active-target')
    else if makefileExists
      try
        atom.commands.dispatch(editorElement, 'build:select-active-target')
    else if platformIOExists
      try
        atom.commands.dispatch(editorElement, 'platomformio:upload')
    else
      try
        atom.commands.dispatch(editorElement, 'script:run-options')



    # console.log "#{filename()}"
    # console.log "Build file exists: #{buildfileExists}"
    # console.log "PlatformIO file exists: #{platformIOExists}"
    # console.log "Make file exists: #{makefileExists}"





    # console.log "#{test}"
    # test2 = (new File([test],false))
    # test3 = new File(["/Users/petersonev/Documents/Other/Hobbies/Programming/Objective-C/Jailbreak-Development/my-projects/WelcomeNotifier/Makefile"],false)
    # test4 = test3.getPath()
    # test_a = fs.exists('/Users')
    # test_b = fs.exists("debs")


    #   console.log "catch"
    # # test3 = test2.exists()
    # # fd_read = cfs_open(test+"/Makefile", CFS_READ);
    # console.log "#{test_a}"
    # console.log "#{test_b}"
    # editor = atom.workspace.getActiveEditor()

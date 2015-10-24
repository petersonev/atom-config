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

# process.env.PATH = ["/opt/theos/bin:/opt/local/bin:/opt/local/sbin:/Library/Frameworks/Python.framework/Versions/2.7/bin:/tmp/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"]
# process.env.THEOS = ["/opt/theos"]

# process.env["test"] = "a"

path = require 'path'
fs = require 'fs'


process.env.PATH = ["/Library/Frameworks/Python.framework/Versions/2.7/bin",process.env.PATH].join(":")
process.env.PATH = ["/opt/local/bin:/opt/local/sbin",process.env.PATH].join(":")

process.env.THEOS = "/opt/theos"
process.env.PATH = ["#{process.env.THEOS}/bin",process.env.PATH].join(":")

process.env.THEOS_DEVICE_IP = "iPhone-6.local"
process.env.THEOS_DEVICE_PORT = 22


# {SelectListView,View} = require 'atom'
# {$, View} = require './space-pen-extensions'



# module.exports =
# class MySelectListView extends View
#   initialize: () ->
#     super
#     @addClass('overlay from-top')
#     @setItems(['Hello', 'World'])
#     atom.workspaceView.append(this)
#     @focusFilterEditor()
#
#   viewForItem: (item) ->
#     "<li>#{item}</li>"

  # confirmed: (item) ->
  #   console.log("#{item} was selected")



# config = [process.env.HOME,".bash_profile"].join("/")
#
# out = fs.readFileSync config, 'utf8'
# # out_2 = out.split("\n")
#
# for i in out.split("\n")
#   if (i.indexOf "export",0) == 0
#     trim = (i.replace /^\s+/g, "").split("=")
#     name = trim[0]
#     val =  trim.slice(1,trim.length).join("=")
#     if name == "PATH"
#       process.env.PATH = [val,process.env.PATH].join(":")
#
#     # console.log [trim[0], trim.slice(1,trim.length).join("=")]
#
# console.log out.split("\n")

# {$} = require 'atom'
#
# cpb = $('<a href="">Start</a>').css
#   'position': 'absolute'
#   'float': 'left'
#   'right': 3
#   'height': 34
#   'line-height': '32px'
#   'overflow': 'hidden'
#
# cpb.on 'click', ->
#   atom.workspaceView.trigger 'command-palette:toggle'

# $('.panes').append cpb

# view = document.createElement('my-find')
# @panel = atom.workspace.addBottomPanel item: view



buildfileExists = true
platformIOExists = true
makefileExists = true

checkbuild = ->
  projectPath = atom.project.getPaths()

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
    else if type == "tex"
      try
        atom.commands.dispatch(editorElement, 'latex:build')
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
    type = getFileType()
    editorElement = atom.views.getView(atom.workspace.getActiveTextEditor())
    if type == "tex"
      try
        atom.commands.dispatch(editorElement, 'latex:clean')
    else if buildfileExists
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

{CompositeDisposable} = require 'atom'
{$} = require 'atom-space-pen-views'

module.exports = CopyOnSelect =
  subscriptions: new CompositeDisposable

  activate: ->
    # Register command that toggles this view
    @subscriptions.add atom.workspace.observeTextEditors (editor) =>
        editorView = atom.views.getView(editor)
        $(editorView).on 'mouseup.copy-on-select', (event) ->
            if event.which != 1 then return

            text = editor.getSelectedText()
            if text == "" then return
            if /^\s*$/.test(text) then return
            atom.clipboard.write(text)
            console.log("Copied: " + text)

  deactivate: ->
    @subscriptions.dispose()
    for editor in atom.workspace.getTextEditors()
        editorView = atom.views.getView(editor)
        $(editorView).off('.copy-on-select')

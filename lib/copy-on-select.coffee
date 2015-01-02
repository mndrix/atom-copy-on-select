{CompositeDisposable} = require 'atom'

module.exports = AtomCopyOnSelect =
  subscriptions: null

  activate: ->
    # Register command that toggles this view
    @subscriptions = atom.workspace.observeTextEditors (editor) =>
        editor.onDidChangeSelectionRange (event) ->
            sel = event.selection
            if sel.isEmpty() then return

            text = sel.getText()
            if text == "" then return
            if /^\s*$/.test(text) then return

            atom.clipboard.write(text)
            console.log("Copied: " + text)

  deactivate: ->
    @subscriptions.dispose()

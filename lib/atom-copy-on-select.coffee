AtomCopyOnSelectView = require './atom-copy-on-select-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomCopyOnSelect =
  atomCopyOnSelectView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomCopyOnSelectView = new AtomCopyOnSelectView(state.atomCopyOnSelectViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomCopyOnSelectView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-copy-on-select:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomCopyOnSelectView.destroy()

  serialize: ->
    atomCopyOnSelectViewState: @atomCopyOnSelectView.serialize()

  toggle: ->
    console.log 'AtomCopyOnSelect was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

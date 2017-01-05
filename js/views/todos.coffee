`var app = app || {}`


@TodoView = Backbone.View.extend
  tagName: "li"
  template: _.template( $("#item-template").html() )
  events:
    "click .toggle": "toggleCompleted"
    "dblclick label": "edit"
    "click .destroy": "clear"
    "keypress .edit": "updateOnEnter"
    "blur .edit": "close"

  initialize: ->
    this.listenTo this.model, "change", this.render
    this.listenTo this.model, "destroy", this.remove
    this.listenTo this.model, "visible", this.toggleVisible

  render: ->
    console.log "rendering todo"
    this.$el.html this.template(this.model.attributes)
    this.$el.toggleClass("completed", this.model.get("completed"))
    this.toggleVisible()
    this.$input = this.$(".edit")
    this

  toggleVisible: ->
    this.$el.toggleClass("hidden", this.isHidden())

  # determines if item should be hidden
  isHidden: ->
    isCompleted = this.model.get "completed"
    return((!isCompleted && TodoFilter == "completed") || (isCompleted && TodoFilter == "active") )

  # toggle the "completed" state of the model, the change is immediately persisted
  toggleCompleted: ->
    this.model.toggle()

  edit: ->
    console.log "now editing"
    this.$el.addClass "editing"
    this.$input.removeAttr("hidden")
    this.$input.focus()

  close: ->
    value = this.$input.val().trim()

    if value
      this.model.save({title: value})
    else
      this.clear()

    this.$el.removeClass "editing"

  updateOnEnter: (e)->
    if e.which == ENTER_KEY
      this.close()

  clear: ->
    this.model.destroy()

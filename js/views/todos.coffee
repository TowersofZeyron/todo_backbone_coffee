`var app = app || {}`


@TodoView = Backbone.View.extend
  tagName: "li"
  template: _.template( $("#item-template").html() )
  events:
    "dbclick label": "edit"
    "keypress .edit": "updateOnEnter"
    "blur .edit": "close"

  initialize: ->
    this.listenTo this.model, "change", this.render

  render: ->
    this.$el.html this.template(this.model.attributes)
    this.$input = this.$(".edit")
    this

  edit: ->
    this.$el.addClass "editing"
    this.$input.focus()

  close: ->
    value = this.$input.val().trim()

    if value
      this.model.save({title: value})

    this.$el.removeClass "editing"

  updateOnEnter: (e)->
    if e.which == ENTER_KEY
      this.close()

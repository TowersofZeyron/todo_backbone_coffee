`var app = app || {}`
# @TodoFilter = "completed"

@AppView = Backbone.View.extend
  el: "#todoapp"
  statsTemplate: _.template $("#stats-template").html()

  # delegated events for creating new items and clearing completed ones
  events:
    "keypress #new-todo": "createOnEnter"
    "click #clear-completed": "clearCompleted"
    "click #toggle-all": "toggleAllComplete"

  initialize : ->
    this.allCheckbox = this.$("#toggle-all")[0]
    this.$input = this.$("#new-todo")
    this.$footer = this.$("#footer")
    this.$main = this.$("#main")

    this.listenTo Todos, "add", this.addOne
    this.listenTo Todos, "reset", this.addAll
    this.listenTo Todos, "change:completed", this.filterOne
    this.listenTo Todos, "filter", this.filterAll
    this.listenTo Todos, "all", this.render

    # get the Todos from the store
    Todos.fetch()

  # New, re-rendering the app just means refreshing the statistics
  # The rest of the app doesn't change
  render: ->
    completed = Todos.completed().length
    remaining = Todos.remaining().length

    if Todos.length
      this.$main.show()
      this.$footer.show()
      this.$footer.html this.statsTemplate
        completed: completed
        remaining: remaining

      this.$("#filters li a")
        .removeClass "selected"
        .filter('[href="#/' + ( TodoFilter || '' ) +  '"]')
        .addClass "selected"
    else
      this.$main.hide()
      this.$footer.hide()
    this.allCheckbox.checked = !remaining

  addOne: (todo)->
    view = new TodoView({model: todo})
    console.log "adding one todo"
    this.$("#todo-list").append view.render().el

  addAll: ->
    this.$("#todo-list").html ""
    console.log "adding all todos"
    Todos.each this.addOne, this

  filterOne: (todo)->
    todo.trigger "visible"

  filterAll: ->
    Todos.each this.filterOne, this

  # general attributes for a new Todo item
  newAttributes: ->
    title: this.$input.val().trim()
    order: Todos.nextOrder()
    completed: false

  # when you hit return in the todo input field, create a new Todo model
  # persisting it to localStorage
  createOnEnter: (event)->
    if event.which != ENTER_KEY || !this.$input.val().trim()
      return
    console.log "creating a new Todo" 
    Todos.create this.newAttributes()
    this.$input.val ""

  clearCompleted: ->
    _.invoke Todos.completed(), "destroy"
    return false

  toggleAllComplete: ->
    completed = this.allCheckbox.checked

    Todos.each (todo)->
      todo.save {"completed": completed}

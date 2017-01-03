
app.AppView = Backbone.View.extend
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

    this.listenTo app.Todos, "add", this.addOne
    this.listenTo app.Todos, "reset", this.addAll
    this.listenTo app.Todos, "change:completed", this.filterOne
    this.listenTo app.Todos, "filter", this.filterAll
    this.listenTo app.Todos, "all", this.render

    # get the Todos from the store
    app.Todos.fetch()

    # New, re-rendering the app just means refreshing the statistics
    # The rest of the app doesn't change 

  addOne: (todo)->
    view = new app.TodoView({model: todo})
    this.$("#todo-list").append view.render().el

  addAll: ->
    this.$("#todo-list").html ""
    app.Todos.each this.addOne, this



# Todo Collection
TodoList = Backbone.Collection.extend
  model: app.Todo
  localStorage: new Backbone.LocalStorage 'todos-backbone'

  completed: ->
    this.filter (todo)->
      todo.get 'completed'

  remaining: ->
    this.without.apply this, this.completed()

  nextOrder: ->
    if !this.length
      return 1
    this.last().get('order') + 1

  # Todos are sorted by their original insertion order
  comparator: (todo)->
    todo.get 'order'

# create a global collection of Todos
app.Todos = new TodoList()

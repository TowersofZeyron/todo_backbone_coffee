WorkSpace = Backbone.Router.extend
  routes:
    "*filter": "setFilter"

  setFilter: (param)->
    console.log "inside router filter"
    console.log param
    if param
      param = param.trim()
    @TodoFilter = param
    Todos.trigger "filter"

# @TodoFilter = "completed"
@TodoRouter = new WorkSpace()
Backbone.history.start()

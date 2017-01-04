`var app = app || {}`
# Todo Model

@Todo = Backbone.Model.extend
  defaults:
    title: ''
    completed: false

  toggle: ->
    this.save
        completed: !this.get 'completed'

@CrazyMode = {}
@crazyApp = {}

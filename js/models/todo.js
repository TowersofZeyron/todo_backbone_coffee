// Generated by CoffeeScript 1.12.2
(function() {
  var app;

  app = app || {};

  app.Todo = Backbone.Model.extend({
    defaults: {
      title: '',
      completed: false
    },
    toggle: function() {
      return this.save({
        completed: !this.get('completed')
      });
    }
  });

  this.CrazyMode = {};

  this.crazyApp = {};

}).call(this);

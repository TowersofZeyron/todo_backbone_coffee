// Generated by CoffeeScript 1.12.2
(function() {
  var WorkSpace;

  WorkSpace = Backbone.Router.extend({
    routes: {
      "*filter": "setFilter"
    },
    setFilter: function(param) {
      console.log("inside router filter");
      console.log(param);
      if (param) {
        param = param.trim();
      }
      this.TodoFilter = param;
      return Todos.trigger("filter");
    }
  });

  this.TodoRouter = new WorkSpace();

  Backbone.history.start();

}).call(this);

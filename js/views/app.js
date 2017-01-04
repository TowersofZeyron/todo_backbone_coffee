// Generated by CoffeeScript 1.12.2
(function() {
  var app = app || {};
  this.TodoFilter = "all";

  this.AppView = Backbone.View.extend({
    el: "#todoapp",
    statsTemplate: _.template($("#stats-template").html()),
    events: {
      "keypress #new-todo": "createOnEnter",
      "click #clear-completed": "clearCompleted",
      "click #toggle-all": "toggleAllComplete"
    },
    initialize: function() {
      this.allCheckbox = this.$("#toggle-all")[0];
      this.$input = this.$("#new-todo");
      this.$footer = this.$("#footer");
      this.$main = this.$("#main");
      this.listenTo(Todos, "add", this.addOne);
      this.listenTo(Todos, "reset", this.addAll);
      this.listenTo(Todos, "change:completed", this.filterOne);
      this.listenTo(Todos, "filter", this.filterAll);
      this.listenTo(Todos, "all", this.render);
      return Todos.fetch();
    },
    render: function() {
      var completed, remaining;
      completed = Todos.completed().length;
      remaining = Todos.remaining().length;
      if (Todos.length) {
        this.$main.show();
        this.$footer.show();
        this.$footer.html(this.statsTemplate({
          completed: completed,
          remaining: remaining
        }));
        this.$("#filters li a").removeClass("selected").filter('[href="#/' + (TodoFilter || '') + '"]').addClass("selected");
      } else {
        this.$main.hide();
        this.$footer.hide();
      }
      return this.allCheckbox.checked = !remaining;
    },
    addOne: function(todo) {
      var view;
      view = new TodoView({
        model: todo
      });
      return this.$("#todo-list").append(view.render().el);
    },
    addAll: function() {
      this.$("#todo-list").html("");
      return Todos.each(this.addOne, this);
    },
    filterOne: function(todo) {
      return todo.trigger("visible");
    },
    filterAll: function() {
      return Todos.each(this.filterOne, this);
    },
    newAttributes: function() {
      return {
        title: this.$input.val().trim(),
        order: Todos.nextOrder(),
        completed: false
      };
    },
    createOnEnter: function(event) {
      if (event.which !== ENTER_KEY || !this.$input.val().trim()) {
        return;
      }
      alert("creating a new Todo");
      Todos.create(this.newAttributes());
      return this.$input.val("");
    },
    clearCompleted: function() {
      _.invoke(Todos.completed(), "destroy");
      return false;
    },
    toggleAllComplete: function() {
      var completed;
      completed = this.allCheckbox.checked;
      return Todos.each(function(todo) {
        return todo.save({
          "completed": completed
        });
      });
    }
  });

}).call(this);

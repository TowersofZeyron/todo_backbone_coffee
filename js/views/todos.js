// Generated by CoffeeScript 1.12.2
(function() {
  var app = app || {};
  this.TodoView = Backbone.View.extend({
    tagName: "li",
    template: _.template($("#item-template").html()),
    events: {
      "dbclick label": "edit",
      "keypress .edit": "updateOnEnter",
      "blur .edit": "close"
    },
    initialize: function() {
      return this.listenTo(this.model, "change", this.render);
    },
    render: function() {
      this.$el.html(this.template(this.model.attributes));
      this.$input = this.$(".edit");
      return this;
    },
    edit: function() {
      this.$el.addClass("editing");
      return this.$input.focus();
    },
    close: function() {
      var value;
      value = this.$input.val().trim();
      if (value) {
        this.model.save({
          title: value
        });
      }
      return this.$el.removeClass("editing");
    },
    updateOnEnter: function(e) {
      if (e.which === ENTER_KEY) {
        return this.close();
      }
    }
  });

}).call(this);

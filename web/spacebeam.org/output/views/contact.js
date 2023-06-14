fun.views.contact = Backbone.View.extend({

    events: {

    },

    initialize : function(options) {
        fun.containers.contact = this.$el;
    },
    
    render : function(){
        var template = _.template(
            fun.utils.getTemplate(fun.conf.templates.contact)
        );
        this.$el.html(template);
        this.$el.removeClass("hide").addClass("show");
    }

});
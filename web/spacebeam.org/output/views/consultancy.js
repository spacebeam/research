// lets do this! 

var payload = {
    hide_validation: false,
    button_orientation: "left",
    fields: [{
                id: "first_name",
                name: "What is your name?",
                type: "field",
                field: {
                    type: "text",
                    placeholder: "Name"
                }
            },
            {
                id: "email",
                name: "What is your email?",
                type: "field",
                field: {
                    type: "text",
                    placeholder: "Email",
                }
            },
            {
                id: "capability",
                name: "Pick a capability",
                type: "field",
                field: {
                    type: "select",
                    default_value: "Consultancy",
                    options: ["Consultancy", "Training", "Support"]
                }
            },
            {
                id: "message",
                name: "Message",
                type: "field",
                field: {
                    type: "textarea",
                    placeholder: "Your message",
                }
            }, 
            {
                            id: "switchon",
                            name: "Opt-in communication, I agree to Spacebeam Privacy Policy.",
                            type: "field",
                            field: {
                                type: "switch",
                                default_value: "false",
                            }
                        }, 
    ]
}

fun.views.consultancy = Backbone.View.extend({

    events: {
        'change input': 'submit',
    },

    initialize: function(options){
        fun.containers.consultancy = this.$el;
        const Form1Data = document.getElementById("Form1Data")
        const Form1Instance = document.getElementById("Form1Instance")
        const Form1Status = document.getElementById("Form1Status")
        this.rawJson = this.$("#rawJson");
    },

    render: function(){
        var template = _.template(
            fun.utils.getTemplate(fun.conf.templates.consultancy)
        );
        this.$el.html(template);
        this.$el.removeClass("hide").addClass("show");
        const jsonForm = new JsonForm();

        // Builds the form in the UI
        function buildForm() {
            //this.rawJson.innerHTML = JSON.stringify(payload, null, 2)
            jsonForm.create("#Form1", JSON.parse(JSON.stringify(payload, null, 2)), "Form1")
            //jsonForm.createForm("Form1", "Form1", payload, handleData)
        }
        
        buildForm()
    },

    submit: function(event) {
        'use strict';
        event.preventDefault();
        console.log('pog');
    }
});

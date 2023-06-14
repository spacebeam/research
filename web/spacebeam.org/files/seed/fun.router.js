/*
* In a client-server architecture routes are resource address capability service nouns.
*/
fun.Router = Backbone.Router.extend({
    /*
     Seed server routes
    */
    routes: {
        "": "home",
        "home": "home",
        "zerg": "landing",
        "work": "consultancy",
        "us": "contact"
    },
    initialize: function(){
        'use strict';
        // landing
        fun.instances.landing = new fun.views.landing({
            el:"#fun-landing"
        });
        // contact
        fun.instances.contact = new fun.views.contact({
            el:"#fun-contact"
        });
        // consultancy
        fun.instances.consultancy = new fun.views.consultancy({
            el:"#fun-consultancy"
        });
    },
    home: function(){
        'use strict';
        // get account and context
        this.account = localStorage.getItem("username");
        this.context = sessionStorage.getItem("context");
        if (this.account === this.context){
            console.log('account same as context');
        } else {
            console.log('missing or different context');
        }
        if(fun.utils.loggedIn()){
            fun.utils.redirect(fun.conf.hash.dashboard);
        } else {
            fun.utils.redirect(fun.conf.hash.landing);
        }
    },
    landing: function(){
        'use strict';
        fun.utils.hideAll();
        fun.instances.landing.render();
    },
    dashboard: function(){
        'use strict';
        fun.utils.hideAll();
        fun.instances.dashboard.render();
    },
    consultancy: function(){
        'use strict';
        fun.utils.hideAll();
        fun.instances.consultancy.render();
    },
    contact: function(){
        'use strict';
        fun.utils.hideAll();
        fun.instances.contact.render();
    }
});
// init the shit out of this
$(function(){
    fun.instances.router = new fun.Router();
    Backbone.history.start();
});

/*
 Seed models configuration
*/

fun.models.Account = Backbone.Model.extend({

    idAttribute: 'uuid',
    
    initialize: function(options){
        if (typeof(options) != "undefined"){
            this.account = options.account;    
        }
    },
    
    urlRoot: fun.conf.urls.user,
    
    url: function(){
        var url;
        if (this.account){
            url = this.urlRoot.replace(fun.conf.account, this.account);    
        }
        if (!this.isNew()){
            url += '/' + this.id;
        } else {
            url = fun.conf.urls.users;
        }
        return url;
    },

    sync: function(method, model, options){
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Upload = Backbone.Model.extend({

    urlRoot: fun.conf.urls.upload,

    url: function(){
        return this.urlRoot;
    }
});


fun.models.login = Backbone.Model.extend({

    urlRoot: fun.conf.urls.login,

    url: function(){
        return this.urlRoot;
    }
});


fun.models.logout = Backbone.Model.extend({

    urlRoot: fun.conf.urls.logout,

    url: function(){
        return this.urlRoot;
    }
});


fun.models.User = Backbone.Model.extend({

    idAttribute: 'uuid',
    
    initialize: function(options) {
        this.account = options.account;
    },
    
    urlRoot: fun.conf.urls.user,
    
    url: function(){
        var url = this.urlRoot.replace(fun.conf.account, this.account);
        //if (!this.isNew()){
        //    url += '/' + this.id;
        //}
        return url;
    },
    
    sync: function(method, model, options){
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
}); 


fun.models.Users = Backbone.Collection.extend({

    model: fun.models.User,
    
    urlRoot: fun.conf.urls.users,
    
    url: function(){
        return this.urlRoot;
    },
    
    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Org = Backbone.Model.extend({

    idAttribute: 'uuid',
    
    initialize: function(options) {
        this.account = options.account;
    },
    
    urlRoot: fun.conf.urls.org,

    url: function(){
        var url = this.urlRoot.replace(fun.conf.account, this.account);
        if (!this.isNew()){
            url += '/' + this.id;
        }
        return url;
    },
    
    sync: function(method, model, options){
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
}); 


fun.models.Orgs = Backbone.Collection.extend({

    model: fun.models.Org,
    
    urlRoot: fun.conf.urls.orgs,
    
    url: function(){
        return this.urlRoot;
    },
    
    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Record = Backbone.Model.extend({

    idAttribute: 'uuid',

    initialize: function(options) {
        this.recordId = options.recordId;
    },
    
    urlRoot: fun.conf.urls.record,
    
    url: function() {
        var url = this.urlRoot.replace(fun.conf.recordId, this.recordId);
        if (!this.isNew()){
            url += '/' + this.id;
        }
        return url;
    },
    
    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Records = Backbone.Collection.extend({
    
    model: fun.models.Record,
    
    urlRoot: fun.conf.urls.records,
    
    url: function() {
        return this.urlRoot;
    },
    
    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },
    
    parse: function(response) {
        return response.results;
    }
});


fun.models.RecordsStart = Backbone.Collection.extend({
    
    model: fun.models.Record,

    initialize: function(options){
        this.start = options.start;
    },

    urlRoot: fun.conf.urls.recordsStart,

    url: function(){
        var url = this.urlRoot.replace(fun.conf.startTime, this.start);
        //url = url.replace(fun.conf.startTime, this.start);
        return url;
    },

    sync: function(method, model, options){
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.results;
    }
});


fun.models.RecordsStartEnd = Backbone.Collection.extend({
    
    model: fun.models.Record,

    initialize: function(options){
        this.start = options.start;
        this.end = options.end;
    },

    urlRoot: fun.conf.urls.recordsStartEnd,

    url: function(){
        var url = this.urlRoot.replace(fun.conf.startTime, this.start);

        url = url.replace(fun.conf.endTime, this.end);
        
        return url;
    },

    sync: function(method, model, options){
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.results;
    }
});


fun.models.LapseSummary = Backbone.Model.extend({

    idAttribute: 'uuid',
    
    initialize: function(options) {
        this.lapse = options.lapse;
    },
    
    urlRoot: fun.conf.urls.lapseSummary,
    
    url: function(){
        var url = this.urlRoot.replace(fun.conf.lapse, this.lapse);
        return url;
    },
    
    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.LapseSummaries = Backbone.Collection.extend({
    
    model: fun.models.LapseSummary,

    initialize: function(options) {
        this.lapse = options.lapse;
    },

    urlRoot: fun.conf.urls.lapseSummaries,

    url: function(){
        var url = this.urlRoot.replace(fun.conf.lapse, this.lapse);
        return url;
    },

    sync: function(method, model, options){
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.results;
    }
});


fun.models.LapseSummaryStart = Backbone.Model.extend({

    idAttribute: 'uuid',

    initialize: function(options){
        this.lapse = options.lapse;
        this.start = options.start;
    },

    urlRoot: fun.conf.urls.lapseSummaryStart,

    url: function(){
        var url = this.urlRoot.replace(fun.conf.lapse, this.lapse);
        url = url.replace(fun.conf.startTime, this.start);
        return url;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }

});


fun.models.LapseSummaryStartEnd = Backbone.Model.extend({

    idAttribute: 'uuid',
    
    initialize: function(options){
        this.lapse = options.lapse;
        this.start = options.start;
        this.end = options.end;
    },

    urlRoot: fun.conf.urls.lapseSummaryStartEnd,

    url: function(){
        var url = this.urlRoot.replace(fun.conf.lapse, this.lapse);
        url = url.replace(fun.conf.startTime, this.start);
        url = url.replace(fun.conf.endTime, this.end);
        return url;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }

});


fun.models.Summary = Backbone.Model.extend({

    idAttribute: 'uuid',
    
    urlRoot: fun.conf.urls.summary,
    
    url: function(){
        return this.urlRoot;
    },
    
    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Summaries = Backbone.Collection.extend({
   
    model: fun.models.Summary,

    urlRoot: fun.conf.urls.summaries,

    url: function(){
        return this.urlRoot;
    },

    sync: function(method, model, options){
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.results;
    }
});


fun.models.SummaryStart = Backbone.Model.extend({

    idAttribute: 'uuid',

    initialize: function(options){
        this.start = options.start;
    },

    urlRoot: fun.conf.urls.summaryStart,

    url: function(){
        var url = this.urlRoot.replace(fun.conf.startTime, this.start);
        return url;
    },

    sync: function(method, model, options){
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }

});


fun.models.SummariesStart = Backbone.Collection.extend({
   
    model: fun.models.SummaryStart,

    initialize: function(options){
        this.start = options.start;
    },

    urlRoot: fun.conf.urls.summariesStart,

    url: function(){
        var url = this.urlRoot.replace(fun.conf.startTime, this.start);
        return url;
    },

    sync: function(method, model, options){
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.results;
    }
});


fun.models.SummaryStartEnd = Backbone.Model.extend({

    idAttribute: 'uuid',

    initialize: function(options){
        this.start = options.start;
        this.end = options.end;
    },

    urlRoot: fun.conf.urls.summaryStartEnd,

    url: function(){
        var url = this.urlRoot.replace(fun.conf.startTime, this.start);
        url = url.replace(fun.conf.endTime, this.end);
        return url;
    },

    sync: function(method, model, options){
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.SummariesStartEnd = Backbone.Collection.extend({
   
    model: fun.models.SummaryStartEnd,

    initialize:function(options){
        this.start = options.start;
        this.end = options.end;
    },

    urlRoot: fun.conf.urls.summariesStartEnd,

    url: function(){
        var url = this.urlRoot.replace(fun.conf.startTime, this.start);
        url = url.replace(fun.conf.endTime, this.end);
        return url;
    },

    sync: function(method, model, options){
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.results;
    }
});


fun.models.Billing = Backbone.Model.extend({

    idAttribute: 'uuid',
    
    urlRoot: fun.conf.urls.billing,
    
    url: function(){
        return this.urlRoot;
    },
    
    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Billings = Backbone.Collection.extend({

    model: fun.models.Billing,

    urlRoot: fun.conf.urls.billings,

    url: function(){
        return this.urlRoot;
    },

    sync: function(method, model, options){
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.results;
    }
});


fun.models.BillingStart = Backbone.Model.extend({

    idAttribute: 'uuid',

    initialize: function(options){
        this.start = options.start;
    },

    urlRoot: fun.conf.urls.billingStart,

    url: function(){
        var url = this.urlRoot.replace(fun.conf.startTime, this.start);
        return url;
    },

    sync: function(method, model, options){
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.BillingStartEnd = Backbone.Model.extend({

    idAttribute: 'uuid',

    initialize: function(options){
        this.start = options.start;
        this.end = options.end;
    },

    urlRoot: fun.conf.urls.billingStartEnd,

    url: function(){
        var url = this.urlRoot.replace(fun.conf.startTime, this.start);
        url = url.replace(fun.conf.endTime, this.end);
        return url;
    },

    sync: function(method, model, options){
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.PhoneNumber = Backbone.Model.extend({

    idAttribute: 'uuid',

    initialize: function(options) {
        this.phoneNumberId = options.phoneNumberId;
    },

    urlRoot: fun.conf.urls.phoneNumber,

    url: function() {
        var url = this.urlRoot.replace(fun.conf.phoneNumberId, this.phoneNumberId);
        if (!this.isNew()){
            url += '/' + this.id;
        } else {
            url = fun.conf.urls.phoneNumbers;
        }
        return url;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.PhoneNumbers = Backbone.Collection.extend({

    model: fun.models.PhoneNumber,

    urlRoot: fun.conf.urls.PhoneNumbers,

    url: function() {
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.phoneNumbers;
    }
});


fun.models.Contact = Backbone.Model.extend({

    idAttribute: 'uuid',

    initialize: function(options) {
        this.contactId = options.contactId;
    },

    urlRoot: fun.conf.urls.contact,

    url: function() {
        var url = this.urlRoot.replace(fun.conf.contactId, this.contactId);
        if (!this.isNew()){
            url += '/' + this.id;
        } else {
            url = fun.conf.urls.contacts;
        }
        return url;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Contacts = Backbone.Collection.extend({

    model: fun.models.Contact,

    urlRoot: fun.conf.urls.contacts,

    url: function() {
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.contacts;
    }
});


fun.models.Directory = Backbone.Model.extend({

    idAttribute: 'uuid',

    initialize: function(options) {
        this.directoryId = options.directoryId;
    },

    urlRoot: fun.conf.urls.directory,

    url: function() {
        var url = this.urlRoot.replace(fun.conf.directoryId, this.directoryId);
        if (!this.isNew()){
            url += '/' + this.id;
        }
        return url;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Directories = Backbone.Collection.extend({

    model: fun.models.Directory,

    urlRoot: fun.conf.urls.directories,

    url: function() {
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.directories;
    }
});


fun.models.Campaign = Backbone.Model.extend({

    idAttribute: 'uuid',

    initialize: function(options) {
        this.campaignId = options.campaignId;
    },

    urlRoot: fun.conf.urls.campaign,

    url: function() {
        var url = this.urlRoot.replace(fun.conf.campaignId, this.campaignId);
        if (!this.isNew()){
            url += '/' + this.id;
        } else {
            url = fun.conf.urls.campaigns;
        }
        return url;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Campaigns = Backbone.Collection.extend({

    model: fun.models.Campaign,

    urlRoot: fun.conf.urls.campaigns,

    url: function() {
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.campaigns;
    }
});


fun.models.Alert = Backbone.Model.extend({

    idAttribute: 'uuid',

    urlRoot: fun.conf.urls.alert,

    url: function() {
        'use strict';
        var url;
        if (!this.isNew()){
            url = this.urlRoot.replace(fun.conf.uuidAlert, this.id);
        } else {
            url = fun.conf.urls.alerts;
        }
        return url;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Alerts = Backbone.Collection.extend({

    model: fun.models.Alert,

    urlRoot: fun.conf.urls.alerts,

    url: function() {
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.alerts;
    }
});


fun.models.Call = Backbone.Model.extend({

    idAttribute: 'uuid',

    initialize: function(options) {
        this.campaignId = options.callId;
    },

    urlRoot: fun.conf.urls.calls,

    url: function() {
        var url = this.urlRoot.replace(fun.conf.callId, this.callId);
        if (!this.isNew()){
            url += '/' + this.id;
        }
        return url;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Calls = Backbone.Collection.extend({

    model: fun.models.Call,

    urlRoot: fun.conf.urls.calls,

    url: function() {
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.calls;
    }
});


fun.models.Carrier = Backbone.Model.extend({

    idAttribute: 'uuid',

    initialize: function(options) {
        this.carrierId = options.carrierId;
    },

    urlRoot: fun.conf.urls.carrier,

    url: function() {
        var url = this.urlRoot.replace(fun.conf.carrierId, this.carrierId);
        if (!this.isNew()){
            url += '/' + this.id;
        } else {
            url = fun.conf.urls.carriers;
        }
        return url;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Carriers = Backbone.Collection.extend({

    model: fun.models.Carrier,

    urlRoot: fun.conf.urls.carriers,

    url: function() {
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.results;
    }
});


fun.models.Task = Backbone.Model.extend({

    idAttribute: 'uuid',

    urlRoot: fun.conf.urls.task,

    url: function() {
        'use strict';
        var url;
        if (!this.isNew()){
            url = this.urlRoot.replace(fun.conf.uuidTask, this.id);
        } else {
            url = fun.conf.urls.tasks;
        }
        return url;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Tasks = Backbone.Collection.extend({

    model: fun.models.Task,

    urlRoot: fun.conf.urls.tasks,

    url: function() {
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.results;
    }
});

fun.models.Route = Backbone.Model.extend({

    idAttribute: 'uuid',

    urlRoot: fun.conf.urls.route,

    url: function() {
        'use strict';
        var url;
        if (!this.isNew()){
            url = this.urlRoot.replace(fun.conf.uuidRoute, this.id);
        } else {
            url = fun.conf.urls.routes;
        }
        return url;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Routes = Backbone.Collection.extend({

    model: fun.models.Route,

    urlRoot: fun.conf.urls.routes,

    url: function() {
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.results;
    }
});


fun.models.Company = Backbone.Model.extend({

    idAttribute: 'uuid',

    urlRoot: fun.conf.urls.company,

    url: function() {
        'use strict';
        var url;
        if (!this.isNew()){
            url = this.urlRoot.replace(fun.conf.uuidCompany, this.id);
        } else {
            url = fun.conf.urls.companies;
        }
        return url;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Companies = Backbone.Collection.extend({

    model: fun.models.Company,

    urlRoot: fun.conf.urls.companies,

    url: function() {
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    },

    parse: function(response){
        return response.results;
    }
});
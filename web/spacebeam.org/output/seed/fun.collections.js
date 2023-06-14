
fun.models.Gateways = Backbone.Collection.extend({
    model: fun.models.Gateway,

    urlRoot: fun.conf.urls.gateways,

    url: function(){
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
})


fun.models.GatewaysActive = Backbone.Collection.extend({
    model: fun.models.Gateway,

    urlRoot: fun.conf.urls.gatewaysActive,

    url: function(){
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
})


fun.models.GatewaysInbound = Backbone.Collection.extend({
    model: fun.models.Gateway,

    urlRoot: fun.conf.urls.gatewaysInbound,

    url: function(){
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
})


fun.models.GatewaysOutbound = Backbone.Collection.extend({
    model: fun.models.Gateway,

    urlRoot: fun.conf.urls.gatewaysOutbound,

    url: function(){
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
})


fun.models.GatewaysMonitored = Backbone.Collection.extend({
    model: fun.models.Gateway,

    urlRoot: fun.conf.urls.gatewaysMonitored,

    url: function(){
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
})


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



fun.models.UsersActive = Backbone.Collection.extend({

    model: fun.models.User,
    
    urlRoot: fun.conf.urls.usersActive,
    
    url: function(){
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.UsersDisable = Backbone.Collection.extend({

    model: fun.models.User,
    
    urlRoot: fun.conf.urls.usersDisable,
    
    url: function(){
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.UsersSuspended = Backbone.Collection.extend({

    model: fun.models.User,
    
    urlRoot: fun.conf.urls.usersSuspended,
    
    url: function(){
        return this.urlRoot;
    },

    sync: function(method, model, options) {
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


fun.models.Records = Backbone.Collection.extend({
    
    model: fun.models.Record,
    
    urlRoot: fun.conf.urls.records,
    
    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.results;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
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

    parse: function(response){
        return response.results;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
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

    parse: function(response){
        return response.results;
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

    parse: function(response){
        return response.results;
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

    parse: function(response){
        return response.results;
    },

    sync: function(method, model, options) {
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

    parse: function(response){
        return response.results;
    },

    sync: function(method, model, options) {
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

    parse: function(response){
        return response.results;
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

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.ResourcesNodes = Backbone.Collection.extend({
    model: fun.models.Resource,

    urlRoot: fun.conf.urls.resourcesNodes,

    url: function(){
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
})


fun.models.ResourcesImps = Backbone.Collection.extend({
    model: fun.models.Resource,

    urlRoot: fun.conf.urls.resourcesImps,

    url: function(){
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
})


fun.models.ResourcesActive = Backbone.Collection.extend({
    model: fun.models.Resource,

    urlRoot: fun.conf.urls.resourcesActive,

    url: function(){
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
})


fun.models.Contacts = Backbone.Collection.extend({

    model: fun.models.Contact,

    urlRoot: fun.conf.urls.contacts,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.contacts;
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

    parse: function(response){
        return response.directories;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.InboundCampaigns = Backbone.Collection.extend({

    model: fun.models.InboundCampaign,

    urlRoot: fun.conf.urls.campaignsInbound,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.campaigns;
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

    parse: function(response){
        return response.campaigns;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.CampaignsActive = Backbone.Collection.extend({

    model: fun.models.Campaign,

    urlRoot: fun.conf.urls.campaignsActive,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.campaigns;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.CampaignsPaused = Backbone.Collection.extend({

    model: fun.models.Campaign,

    urlRoot: fun.conf.urls.campaignsPaused,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.campaigns;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.CampaignsInbound = Backbone.Collection.extend({

    model: fun.models.Campaign,

    urlRoot: fun.conf.urls.campaignsInbound,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.campaigns;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.CampaignsOutbound = Backbone.Collection.extend({

    model: fun.models.Campaign,

    urlRoot: fun.conf.urls.campaignsOutbound,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.campaigns;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Outbounds = Backbone.Collection.extend({

    model: fun.models.Outbound,

    urlRoot: fun.conf.urls.outbounds,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.outbounds;
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

    parse: function(response){
        return response.alerts;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Recordings = Backbone.Collection.extend({

    model: fun.models.Recording,

    urlRoot: fun.conf.urls.recordings,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.recordings;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.RecordingsInbound = Backbone.Collection.extend({

    model: fun.models.Recording,

    urlRoot: fun.conf.urls.recordingsInbound,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.recordings;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.RecordingsOutbound = Backbone.Collection.extend({

    model: fun.models.Recording,

    urlRoot: fun.conf.urls.recordingsOutbound,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.recordings;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Messages = Backbone.Collection.extend({

    model: fun.models.Message,

    urlRoot: fun.conf.urls.messages,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.messages;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.MessagesUnread = Backbone.Collection.extend({

    model: fun.models.Message,

    urlRoot: fun.conf.urls.messagesUnread,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.messages;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.MessagesAlerts = Backbone.Collection.extend({

    model: fun.models.Message,

    urlRoot: fun.conf.urls.messagesAlerts,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.messages;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Notifications = Backbone.Collection.extend({

    model: fun.models.Message,

    urlRoot: fun.conf.urls.notifications,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.messages;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.TasksStartEndPage = Backbone.Collection.extend({
    
    model: fun.models.Task,

    initialize: function(options){
        this.start = options.start;
        this.end = options.end;
        this.page = options.page;
    },

    urlRoot: fun.conf.urls.tasksStartEndPage,

    url: function(){
        var url = this.urlRoot.replace(fun.conf.startTime, this.start);

        url = url.replace(fun.conf.endTime, this.end);

        url = url.replace(fun.conf.pageNumber, this.page);
        
        return url;
    },

    parse: function(response){
        return response.results;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.TasksNow = Backbone.Collection.extend({

    model: fun.models.Task,

    urlRoot: fun.conf.urls.tasksNow,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.results;
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

    parse: function(response){
        return response.results;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.TasksLater = Backbone.Collection.extend({

    model: fun.models.Task,

    urlRoot: fun.conf.urls.tasksLater,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.results;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.TasksDone = Backbone.Collection.extend({

    model: fun.models.Task,

    urlRoot: fun.conf.urls.tasksDone,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.results;
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

    parse: function(response){
        return response.results;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.CompaniesActive = Backbone.Collection.extend({

    model: fun.models.Company,

    urlRoot: fun.conf.urls.companiesActive,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.results;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.CompaniesDisable = Backbone.Collection.extend({

    model: fun.models.Company,

    urlRoot: fun.conf.urls.companiesDisable,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.results;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.CompaniesSuspended = Backbone.Collection.extend({

    model: fun.models.Company,

    urlRoot: fun.conf.urls.companiesSuspended,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.results;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.Resources = Backbone.Collection.extend({
    model: fun.models.Resource,

    urlRoot: fun.conf.urls.resources,

    url: function(){
        return this.urlRoot;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
})


fun.models.Daemons = Backbone.Collection.extend({

    model: fun.models.Daemon,

    urlRoot: fun.conf.urls.daemons,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response){
        return response.results;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
});


fun.models.AddressPrimary = Backbone.Collection.extend({

    model: fun.models.Address,

    urlRoot: fun.conf.urls.addressesPrimary,

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


fun.models.Addresses = Backbone.Collection.extend({

    model: fun.models.Address,

    urlRoot: fun.conf.urls.addresses,

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


fun.models.Memberships = Backbone.Collection.extend({

    model: fun.models.Membership,

    urlRoot: fun.conf.urls.memberships,

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


fun.models.TasksContainer = Backbone.Model.extend({
    defaults: {
        results: new fun.models.Tasks(),
    },

    urlRoot: fun.conf.urls.tasks,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response) {
        // update the inner collection
        this.get("results").reset(response.results);

        // this mightn't be necessary
        //delete response.dataPoints;
        return response;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
    
});


fun.models.ContactsContainer = Backbone.Model.extend({
    defaults: {
        results: new fun.models.Contacts(),
    },

    urlRoot: fun.conf.urls.contacts,

    url: function() {
        return this.urlRoot;
    },

    parse: function(response) {
        // update the inner collection
        this.get("results").reset(response.contacts);

        // this mightn't be necessary
        //delete response.contacts;
        return response;
    },

    sync: function(method, model, options) {
        options.contentType = 'application/json';
        return Backbone.sync(method, model, options);
    }
    
});
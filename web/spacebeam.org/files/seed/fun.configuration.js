/*
 Configuration seed
*/
fun.conf = {
    // username account
    account: 'account',
    // dashboard context "organization"
    context: 'context',
    // html templates
    html: '/html',
    // internet domain
    domain: 'spacebeam.org',
    // seed url root
    urlRoot: '/api/',
    
    // system uuid's
    uuidAlert: 'alert_uuid',
    uuidContact: 'contact_uuid',
    uuidTask: 'task_uuid',

    lapse: 'lapse',

    startTime: 'start_time',
    endTime: 'end_time',

    first: 'first',
    last: 'last',

    next: 'next',
    previous: 'previous',

    pageNumber: 'page_number',
    pageSize: 'page_size',
    pageSmall: 8,
    pageMedium: 13,
    pageBig: 21
};

/*
 System urls
*/
fun.conf.urls = {
    upload: '/upload/',
    login: '/login/',
    logout: '/logout/',

    user: fun.utils.format('/users/%s', fun.conf.account),
    users: '/users/',

    contact: fun.utils.format('/contacts/%s', fun.conf.uuidContact),
    contacts: '/contacts/',

    alert: fun.utils.format('/alerts/%s', fun.conf.uuidAlert),
    alerts: '/alerts/',

    task: fun.utils.format('/tasks/%s', fun.conf.uuidTask),
    tasks: '/tasks/',

    /*sounds, recordings*/
};

/*
 HTML templates
*/
fun.conf.templates = {
    navbar: fun.utils.format('%s/navbar.html', fun.conf.html),
    
    navLanding: fun.utils.format('%s/navLanding.html', fun.conf.html),
    navDashboard: fun.utils.format('%s/navDashboard.html', fun.conf.html),
    
    subheader: fun.utils.format('%s/subheader.html', fun.conf.html),
    headNav: fun.utils.format('%s/headNav.html', fun.conf.html),
    
    landing: fun.utils.format('%s/landing.html', fun.conf.html),
    
    signup: fun.utils.format('%s/signup.html', fun.conf.html),

    login: fun.utils.format('%s/login.html', fun.conf.html),
    
    dashboard: fun.utils.format('%s/dashboard.html', fun.conf.html),
    
    message: fun.utils.format('%s/message.html', fun.conf.html),
    messageSmall: fun.utils.format('%s/messageSmall.html', fun.conf.html),
    messageMedium: fun.utils.format('%s/messageMedium', fun.conf.html),
    messageLarge: fun.utils.format('%s/messageLarge', fun.conf.html),

    warning: fun.utils.format('%s/warning.html', fun.conf.html),
    warningSmall: fun.utils.format('%s/warningSmall.html', fun.conf.html),
    warningMedium: fun.utils.format('%s/warningMedium.html', fun.conf.html),
    warningLarge: fun.utils.format('%s/warningLarge.html', fun.conf.html),

    error: fun.utils.format('%s/error.html', fun.conf.html),
    errorSmall: fun.utils.format('%s/errorSmall.html', fun.conf.html),
    errorMedium: fun.utils.format('%s/errorMedium.html', fun.conf.html),
    errorLarge: fun.utils.format('%s/errorLarge.html', fun.conf.html),

    consultancy: fun.utils.format('%s/consultancy.html', fun.conf.html),

    contact: fun.utils.format('%s/contact.html', fun.conf.html),
    contacts: fun.utils.format('%s/contacts.html', fun.conf.html),
    allContacts: fun.utils.format('%s/allContacts.html', fun.conf.html),
};

/*
 Hash tags for backbone.js router
*/
fun.conf.hash = {
    home: '#go',
    landing: '#zerg',
    consultancy: '#work',
    contact: '#us'
};

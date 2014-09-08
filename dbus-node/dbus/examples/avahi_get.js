var DBus = require('../');

var dbus = new DBus();

var bus = dbus.getBus('system');

var deviceList = {}
function showDeviceList(){
    console.log("=====device list as below=====");
    for(p in deviceList){
        console.log(p + " : ", deviceList[p]);
    }
    console.log();
}
function resolve_service(arg){
	bus.getInterface('org.freedesktop.Avahi', '/', 'org.freedesktop.Avahi.Server', function(err, iface) {
		iface.ResolveService['timeout'] = 10000;
		iface.ResolveService['finish'] = function(result) {
			//console.log('---------------------------------------------');
            interface = result[0]
            protocol = result[1]
            name = result[2]
            stype = result[3]
            domain = result[4]
            host = result[5]
            aprotocol = result[6]
            address = result[7]
            port = result[8]
            txt = result[9]
            flags  = result[10]
			//console.log(result);
            deviceList[address] = result;
            showDeviceList();
		};
		iface.ResolveService(arg[0], arg[1], arg[2], arg[3], arg[4], -1, 0);//arg[5]
	});
}

function start_service_browser(path){
	console.log('path:' + path);		
	bus.getLocalInterface('org.freedesktop.Avahi', path, 'org.freedesktop.Avahi.ServiceBrowser', '../org.freedesktop.Avahi.ServiceBrowser.xml', function(err, iface) {
		if (err != null){
			console.log(err);
		}
		iface.on('ItemNew', function(arg) {
			//console.log('New:');
			//console.log(arguments);
			resolve_service(arguments);
		});
		iface.on('ItemRemove', function(arg) {
			console.log('Remove:');
			console.log(arguments);
			resolve_service(arguments);
		});
	});
}
bus.getInterface('org.freedesktop.Avahi', '/', 'org.freedesktop.Avahi.Server', function(err, iface) {

	iface.ServiceBrowserNew['timeout'] = 1000;
	iface.ServiceBrowserNew['finish'] = function(path) {
		start_service_browser(path);
	};
	iface.ServiceBrowserNew(-1, -1, '_http._tcp', 'local', 0);
	
});

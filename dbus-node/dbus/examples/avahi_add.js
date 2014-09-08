var DBus = require('../');

var dbus = new DBus();

var bus = dbus.getBus('system');

function add_service(path){
	console.log('path:' + path);		
	bus.getInterface('org.freedesktop.Avahi', path, 'org.freedesktop.Avahi.EntryGroup', function(err, iface) {
		if (err != null){
			console.log(err);
		}
		
		//iface.AddService['timeout'] = 1000;
		iface.AddService['error'] = function(err) {
			console.log(err);
		}
		//iface.AddService['finish'] = function(arg) {
			//console.log(arguments);
		//}
		//var one1=new Array('a', 'b', 'c');	
		//var one2=new Array('a', 'b', 'c', 'd');	
		var one1=new Array(1,2,3);	
		var one2=new Array(4,5,6,7);			
		var two=new Array(2);
		two[0] = one1;
		two[1] = one2;
		iface.AddService(-1, -1, 0, 'TestService1', '_http._tcp', '', '', 3000,  two);
		iface.Commit();
	});
	
}

bus.getInterface('org.freedesktop.Avahi', '/', 'org.freedesktop.Avahi.Server', function(err, iface) {

	iface.EntryGroupNew['timeout'] = 1000;
	iface.EntryGroupNew['finish'] = function(path) {
		add_service(path);
	};
	iface.EntryGroupNew();
	
});

if (!imei) {
	var imei = '';
};
// if ($('.form-submit').length > 0) {
// 	$('.form-submit').on('click', '#J_submit', function() {
// 		var reg = /^1\d{10}$/.test($('#phoneNumber').val());
// 		if ($("[name='userName']").val() && reg) {
// 			$.ajax({
// 				url: 'https://gouche.jxedt.com/gouche/clue/submit',
// 				data: {
// 					cityid: _cityId,
// 					brandid: _brandId,
// 					seriesid: _seriesId,
// 					classesid: _specId,
// 					name: $("[name='userName']").val(),
// 					phone: $('#phoneNumber').val(),
// 					type: 4,
// 					imei: imei
// 				}
// 			});
// 		};
// 	});
// };

window.mclient = {};
window.mclient.getOS = function() {
	var n = !!navigator.userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/),
		t = navigator.userAgent.indexOf("Android") > -1,
		e = window.location.search;
	return e = e.toLowerCase(), e.indexOf("os=android") > -1 ? "android" : e.indexOf("os=ios") > -1 ? "ios" :
		n ? "ios" : t ? "android" : void 0;
};
window.mclient.iosNative = function(n) {
	window.location.href = "hybrid://nativechannel/" + encodeURI(n);
};
window.mclient.androidNative = function(n) {
	"undefined" != typeof window.stub && window.stub.jsCallMethod(n);
};
window.mclient.nativeMethod = function(n) {
	"undefined" == typeof n && alert("param error");
	var t = JSON.stringify(n);
	"ios" == window.mclient.getOS() ? window.mclient.iosNative(t) : "android" == window.mclient.getOS() && window.mclient
		.androidNative(
			t);
};

function sendActionLocal(json) {
	var self = this;
	if (json.action && json.param) {
		var action = json.action.replace(/\s+/, '');
		if (action) {
			var data = {
				"action": action,
				"param": typeof json.param == 'string' ? JSON.parse(json.param) : json.param,
			};

			// var t = JSON.stringify(data);
			// window.location.href = "hybrid://nativechannel/" + encodeURI(t);
			// window.stub.jsCallMethod(data);

			window.mclient.nativeMethod(data)

		}
	};
};
// if ($('#submitOrder').length > 0) {
// 	$('#submitOrder').click(function() {
// 		var reg = /^1\d{10}$/.test($('#inPhone').val().replace(/ /g, ""));
// 		if ($("#inName").val() && reg) {
// 			$.ajax({
// 				url: 'https://gouche.jxedt.com/gouche/clue/submit',
// 				data: {
// 					cityid: current_city,
// 					classesid: currentCarId,
// 					name: $("#inName").val(),
// 					phone: $('#inPhone').val().replace(/ /g, ""),
// 					type: 17,
// 					tothirdparty: 12,
// 					imei: imei
// 				}
// 			});
// 		};
// 	});
// 	var ev = $._data($('#submitOrder').get(0), 'events')['click'];
// 	$._data($('#submitOrder').get(0), 'events')['click'] = undefined;
// 	$._data($('#submitOrder').get(0), 'events')['click'] = ev.reverse();



// 	var acti = {
// 		"action": "setEventLog",
// 		"param": {
// 			"pagetype": "CarPrice",
// 			"actiontype": "ShowSource",
// 			"param": {
// 				source: 1
// 			}
// 		}
// 	};
// 	sendAction(acti);
// };


window.cameraCallback = function (obj) {
	var headObj =  typeof obj == 'string' ? JSON.parse(obj) : obj;
	alert(headObj)
}

function OpenInstallCallback() {
	alert('OpenInstallCallback')
}

function closeWebView() {
	var param = {
		"action": "didCloseWebView",
		"param": {}
	}
	console.log('closeWebView');
	sendAction(param);
}
var getHeaderAction = {
	"action": "getNativeParams",
	"param": {
		"parametype":"header",
		"callback": "getHeaderCb"
	}
};
window.mclient.nativeMethod(JSON.stringify(getHeaderAction))
window.getHeaderLocal = function (obj) {
	var headObj =  typeof obj == 'string' ? JSON.parse(obj) : obj;
	alert(headObj)
}
// setTimeout(_ => {
// 	closeWebView();
// }, 2000)
// if ($('#submit1').length > 0) {
// 	$('#submit1').click(function() {
// 		var reg = /^1\d{10}$/.test(document.getElementsByName('telphone')[0].value);
// 		var classesid = '';
// 		if (location.href.indexOf('specId_') > -1 && location.href.split('specId_')[1].split('/')[0]) {
// 			classesid = location.href.split('specId_')[1].split('/')[0];
// 		};
// 		if (reg) {
// 			$.ajax({
// 				url: 'https://gouche.jxedt.com/gouche/clue/submit',
// 				data: {
// 					cityid: cityId,
// 					brandid: "",
// 					seriesid: carSeriesId,
// 					classesid: classesid,
// 					name: document.getElementsByName('userName')[0].value,
// 					phone: document.getElementsByName('telphone')[0].value,
// 					type: 18,
// 					tothirdparty: 13,
// 					imei: imei
// 				}
// 			});
// 			closeWebView();
// 		};
// 	});
// };
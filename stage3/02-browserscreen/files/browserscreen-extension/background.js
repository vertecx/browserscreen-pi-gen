const timeouts = [];

// Analyze completed web requests. If the request failed with a bad HTTP status code, schedule a
// page reload. If the request was successful, clear all scheduled page reloads.
chrome.webRequest.onCompleted.addListener((details) => {
	if (details.statusCode !== 200 && details.type === "main_frame" && details.tabId !== -1) {
		timeouts.push(setTimeout(() => {
			chrome.tabs.reload(details.tabId);
		}, 30000));
	} else if (details.statusCode === 200 && details.type === "main_frame" && details.tabId !== -1) {
		while ((timeout = timeouts.pop())) {
			clearTimeout(timeout);
		}
	}
}, {
	"urls": ["*://*/*"]
});

// Capture network related errors like disconnected cables. While Chromium eventually recovers from this
// class of errors by itself, it usually takes a lot longer than 30 seconds.
chrome.webRequest.onErrorOccurred.addListener((details) => {
	if (details.type === "main_frame" && details.tabId !== -1) {
		timeouts.push(setTimeout(() => {
			chrome.tabs.reload(details.tabId);
		}, 30000));
	}
}, {
	"urls": ["*://*/*"]
});

// Hack to catch HTTP errors on first page load. Chromium seems to prioritize page load speed over
// extension load speed which will cause the first page to be loaded before this extension is activated.
// If the load fails with a HTTP error, this extension wouldn't catch it and schedule a reload so the
// error would be displayed forever. Forcing a page reload sometime after this extension is loaded is an
// ugly way to solve this problem.
timeouts.push(setTimeout(() => {
	chrome.tabs.query({currentWindow: true, active : true}, (tabs) => {
		if (tabs.length > 0) {
			chrome.tabs.reload(tabs[0].id);
		}
	});
}, 2000));

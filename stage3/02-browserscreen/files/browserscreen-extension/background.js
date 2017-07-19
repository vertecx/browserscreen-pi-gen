chrome.webRequest.onCompleted.addListener((details) => {
	if (details.statusCode !== 200 && details.type === "main_frame" && details.tabId !== -1) {
		setTimeout(() => {
			chrome.tabs.reload(details.tabId);
		}, 30000);
	}
}, {
	"urls": ["*://*/*"]
});

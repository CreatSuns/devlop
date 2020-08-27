window.onload = () => {
	alert('sss');
	document.addEventListener('click', () => {
		try {
			// 代码写这里
			window.webkit.messageHandlers.networkTest.postMessage({title:'参数'});
		} catch (e) {
			alert('错误');
		}
	});
}
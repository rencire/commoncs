function fakeAjax(url,cb) {
	var fake_responses = {
		"file1": "The first text",
		"file2": "The middle text",
		"file3": "The last text"
	};
	var randomDelay = (Math.round(Math.random() * 1E4) % 8000) + 1000;

	console.log("Requesting: " + url);

	setTimeout(function(){
		cb(fake_responses[url]);
	},randomDelay);
}

function output(text) {
	console.log(text);
}

// **************************************

function getFile(file) {
	return ASQ(function(done){
		fakeAjax(file,done);
	});
}

ASQ().runner(function *main() {
	var file1 = getFile('file1');
	var file2 = getFile('file2');
	var file3 = getFile('file3');

	output(yield file1);
	output(yield file2);
	output(yield file3);

	output('Completed');
});

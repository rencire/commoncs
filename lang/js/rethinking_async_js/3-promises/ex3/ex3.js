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
	// what do we do here?
	return new Promise(function executor(resolve, reject){
		fakeAjax(file, resolve);
	});
}

// request all files at once in "parallel"
// ???

var p1 = getFile('file1');
var p2 = getFile('file2');
var p3 = getFile('file3');

p1
.then(output)
.then(function(){ // .then is called from a new Promise returned from the previous `.then` call (not same promise as p1!)
	return p2;
})
.then(output)
.then(function(){
    return p3;
})
.then(output)
.then(function(){
	output('Completed');
});

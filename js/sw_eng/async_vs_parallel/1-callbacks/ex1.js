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
// The old-n-busted callback way

var cur_idx = 0;
var req_cnt = 0;
var texts = [];

function getFile(file) {
  req_cnt += 1;

	fakeAjax(file,function(text){
		// change code here
		handleResp(filename, contents);
	});
}

function handleResp(file, text) {
		var idx = parseInt(file.slice(-1)) - 1;

		texts[idx] = text;

		while(cur_idx < req_cnt) {
			if(texts[cur_idx] === undefined) {
				break;
			}
			output(texts[cur_idx]);
			cur_idx += 1;
		}

		if(cur_idx === req_cnt) {
			output('Done!');
		}

}

// request all files at once in "parallel"
getFile("file1");
getFile("file2");
getFile("file3");

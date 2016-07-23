// Eric Ren 2016
//
// Documentation for functions from MDN:
// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference
//
//
// forEach
Array.prototype.forEach = function(func, thisArg) {
  var ary = this;

  for (var i = 0, len = ary.length; i < len; i++) {
    func.call(thisArg, ary[i], i, ary);
  }
};


/*
[1,2,3].forEach(function(ele, i, ary) {
  console.log(ele);
  console.log(i);
  console.log(ary);
});


var obj = {
  sum: 0
};

[1,2,3].forEach(function(ele, i, ary) {
  this.sum += ele;
}, obj);

console.log(obj.sum);
*/



// map
Array.prototype.map = function(func, thisArg) {
  var ary = this;
  var res = [];

  for (var i = 0, len = ary.length; i < len; i++) {
    res.push(func.call(thisArg, ary[i], i)); 
  }

  return res;
};

/*
var a = [1,2,3];
var res = a.map(function(ele, i, ary) {
  return ele * ele;
});

console.log(res);

var o2 = {
  b: 3
};

var res2 = a.map(function(ele, i, ary) {
  return this.b + ele;
}, o2);

console.log(res2);
*/



// reduce
Array.prototype.reduce = function(func, initVal) {
  if (this.length < 1) {
    return;
  }

  var prev;
  var i;

  if (initVal === undefined) {
    prev =  this[0];
    i = 1;
  } else {
    prev = initVal;
    i = 0;
  }

  for (var len = this.length;  i < len; i++) {
    prev = func(prev, this[i], i, this);
  }

  return prev;

};

/*
var c = [1,2,3,4];

var res = c.reduce(function(prev, cur, i, ary) {
  console.log(prev);
  console.log(cur);
  console.log(i);
  console.log(ary);
  return prev + cur;
}, 100);
console.log(res);
*/




// filter
Array.prototype.filter = function(func, thisArg) {
  var res = [];

  for (var i = 0, len = this.length; i < len; i++) {
    var isKeep = func.call(thisArg, this[i], i, this);
    if (isKeep) {
      res.push(this[i]);
    }
  }
    
  return res;
};


/*
var d = [1,2,3,4];

var res = d.filter(function(cur, i, ary) {
  console.log(cur);
  console.log(i);
  console.log(ary);
  return (cur % 2) === 0;
});

console.log(res);

var obj = {
  num: 3
};

var res2 = d.filter(function(cur, i, ary) {
  console.log(this.num);
  return (cur % this.num) === 0;
}, obj);


console.log(res2);
*/

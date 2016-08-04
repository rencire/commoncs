// Quiz 1
function funky(o) {
  o = null;
}

var x = []
funky(x);
console.log(x);

// Q: what is x?
// A: x is []
// - pass by value, not reference.  Here, we are passing the contents of the variable as parameter 'o'. However, we are not modifying the original reference, hence `x` does not change.

// Quix 2
function swap(a, b) {
  var temp = a;
  a = b;
  b = temp;
}
var x = 1, y = 2;
swap(x, y);
console.log(x);

// Q: what is x?
// A: x is 1
//
//


// Challenge 1
// Write three binary functions, add, sub, and mul.

function add(a,b) {
  return a + b;
}

function sub(a, b) {
  return a - b;
}

function mul(a, b) {
  return a * b;
}

// Write a function `indentityf` that takes an arg and returns a function that returns that arg.

// var three = identityf(3);
// three() //3

function identityf(a) {
  return function() {
    return a;
  };
}

// Write a function `addf` that adds from two invocations.
//
// add(3)(4) // 7

function addf(a) {
  return function(b) {
    return a + b;
  };
}


// Write a function `liftf` that takes a binary function, and makes it callable with two invocations
//
// var addf = liftf(add);
// addf(3)(4)       // 7
// liftf(mul)(5)(6) // 30

function liftf(f) {
  return function(a) {
    return function(b) {
      return f(a, b);
    };
  };
}

var res = liftf(add)(3)(4);
console.log(res);
console.log(res === 7);

res = liftf(mul)(3)(4);
console.log(res);
console.log(res === 12);
















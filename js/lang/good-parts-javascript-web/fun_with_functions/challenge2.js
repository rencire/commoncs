function add(a,b) {
  return a + b;
}

function sub(a,b) {
  return a - b;
}

function mul(a,b) {
  return a * b;
}

// Challenge 2
// 
// Write a function `curry` that takes a binary function and an argument, and returns a function that can take a second argument.
//
// var add3 = curry(add, 3);
// add3(4) //7
//
// curry(mul, 5)(6)

function curry(f, a) {
  return function(b) {
    return f(a,b);
  };
}

var add3 = curry(add, 3);
var res = add3(4);
console.log(res);
console.log(res === 7);

res = curry(mul, 3)(5);
console.log(res);
console.log(res === 15);

// Alt sol, reuse liftf from challenge1.js
// function curry(f, a) {
//   return liftf(f)(a);
// }

// curry with functions that take any number of args
function curry(func) {
  var slice = Array.prototype.slice,
      args = slice.call(arguments, 1);

  return function () {
    return func.apply(null, args.concat(slice.call(arguments, 0)));
  };
}

var addc = curry(add, 3);
// args = [3]

addc(4,5)
// args = [3, 4,5]
//

// es6
// function curry(func, ...first) {
//   return function (...second) {
//       return func(...first, ...second);
//   };
// }

// what currying multiple times?



// Without writing any new functions, show three ways to create the `inc` function
// var inc = ___;
// inc(5) //6
// inc(inc(5)) //7


var inc = addf(1);
inc = liftf(add)(1);
inc = curry(add, 1);





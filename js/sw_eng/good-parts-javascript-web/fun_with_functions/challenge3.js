// Write a function `twice` that takes a binary function and returns an unary function taht passes argument to the binary function twice.
//
// add(11, 11) // 22
// var doubl = twice(add);
// double(11)  // 22
// var square = twice(mul);
// square(11)  // 121

function twice(f) {
  return function(a) {
    return f(a,a);
  };
}


// Write `reverse`, a function that reverses the arguments of a binary function.
// var bus = reverse(sub);
// bus(3, 2) // -1

function reverse(f) {
  return function(a, b) {
    return f(b, a);
  };
}

// es6
function reverse(func) {
  return function(...args) {
    return func(...args.reverse());
  }
}

// Write a function `composeu` that takes two unary functions and returns an unary function that calls them both.
//
// composeu(doubl, square)(5) // 100

function composeu(f, g) {
  return function(a) {
    return g(f(a));
  };
}

// Write a function `composeb` that takes two binary functions and returns a function that calls them both.
//  
//  composeb(add, mul)(2, 3, 7)   //35

function composeb(f, g) {
  return function(a, b, c) {
    return g(f(a,b), c);
  };
}


// Write a function `limit` function that allows a  binary function be called a limited number of times.
// var add_ltd = limit(add, 1);
// add_ltd(3, 4) // 7
// add_ltd(3, 5) // undefined

function limit(f, n) {
  return function(a, b) {
    if(n >= 1) {
      n -= 1;
      return f(a,b);
    }
    return undefined;
  };
}

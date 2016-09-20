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
// function reverse(func) {
//   return function(...args) {
//     return func(...args.reverse());
//   }
// }

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
// Write a `from` function that produces a generator that will produce a series of values.
// var index = from(0);
// index() // 0
// index() // 1
// index() // 2 

function from(n) {
  return function() {
    var inc = n; 
    n += 1;
    return inc; 
  };
}

var index = from(0);
console.log(index()); // 0
console.log(index()); // 1
console.log(index()); // 2 

// Write a `to` function that takes a generator and an end value, and returns a generator that will produce numbers up to that limit.
//
// var index = to(from(1), 3);
// index() // 1
// index() // 2
// index() // undefined 

function to(g, end) {
  return function() {
     var val = g();
     if (val < end) {
       return val;
     }
  };
}

var index = to(from(1), 3);
console.log(index()); // 1
console.log(index()); // 2
console.log(index()); // undefined 


function fromTo(start, end) {
  return function() {
    var n = start;
    start += 1;
    if (n < end) {
      return n;
    }
  };
}

function fromTo(start, end) {
  return to(
    from(start),
    end
  );
}

var index = fromTo(0,3);

console.log(index()); // 0
console.log(index()); // 1
console.log(index()); // 2
console.log(index()); // undefined 

function element(ary, gen) {
  return function() {
    var idx = gen();
    if (idx !== undefined) {
      return ary[idx];
    }
  };
}

var ele = element(['a','b','c','d'], fromTo(1,3));

console.log(ele()); // b
console.log(ele()); // c
console.log(ele()); // undefined 


function element(ary, gen) {
  if (gen === undefined) {
     gen = fromTo(0, ary.length);
  }
  return function() {
    var idx = gen();
    if (idx !== undefined) {
      return ary[idx];
    }
  };
}

var ele = element(['a','b','c','d']);

console.log(ele()); // a
console.log(ele()); // b
console.log(ele()); // c
console.log(ele()); // d
console.log(ele()); // undefined 


/// Challenge 5

function collect(gen, ary) {
  return function() {
    var res = gen();
    if (res !== undefined) {
      ary.push(res);
    }
    return res;
  };

}

var array = [],
    col = collect(fromTo(0, 2), array);

console.log(col()); // 0
console.log(col()); // 1
console.log(col()); // undefined
console.log(array); // [0,1]


function filter(gen, pred) {
  return function() {
    var value = gen();
    console.log(value);
    while (value !== undefined && !pred(value)) {
      value = gen();
    }
    return value;
  };
}

var fil = filter(fromTo(0, 5), function third(value) { return (value % 3) === 0;});

console.log(fil()); // 0
console.log(fil()); // 3
console.log(fil()); // undefined/


function collect(gen, ary) {
  return function() {
    var res = gen();
    if (res !== undefined) {
      ary.push(res);
    }
    return res;
  };

}

var array = [],
    col = collect(fromTo(0, 2), array);

console.log(col()); // 0
console.log(col()); // 1
console.log(col()); // undefined
console.log(array); // [0,1]


function filter(gen, pred) {
  return function() {
    var value = gen();
    while (!pred(value)) {
      value = gen();
    }
    return value;
  }
}

var fil = filter(fromTo(0, 5), function third(value) { return (value % 3) === 0;});

console.log(fil()); // 0
console.log(fil()); // 3
console.log(fil()); // undefined
// Write a `from` function that produces a generator that will produce a series of values.
// var index = from(0);
// index() // 0
// index() // 1
// index() // 2 

function from(n) {
    return function () {
        var inc = n;
        n += 1;
        return inc;
    };
}

var index = from(0);
console.log(index()); // 0
console.log(index()); // 1
console.log(index()); // 2 

// Write a `to` function that takes a generator and an end value, and returns a generator that will produce numbers up to that limit.
//
// var index = to(from(1), 3);
// index() // 1
// index() // 2
// index() // undefined 

function to(g, end) {
    return function () {
        var val = g();
        if (val < end) {
            return val;
        }
    };
}

var index = to(from(1), 3);
console.log(index()); // 1
console.log(index()); // 2
console.log(index()); // undefined 


function fromTo(start, end) {
    return function () {
        var n = start;
        start += 1;
        if (n < end) {
            return n;
        }
    };
}

function fromTo(start, end) {
    return to(
        from(start),
        end
    );
}

var index = fromTo(0, 3);

console.log(index()); // 0
console.log(index()); // 1
console.log(index()); // 2
console.log(index()); // undefined 

function element(ary, gen) {
    return function () {
        var idx = gen();
        if (idx !== undefined) {
            return ary[idx];
        }
    };
}

var ele = element(['a', 'b', 'c', 'd'], fromTo(1, 3));

console.log(ele()); // b
console.log(ele()); // c
console.log(ele()); // undefined 


function element(ary, gen) {
    if (gen === undefined) {
        gen = fromTo(0, ary.length);
    }
    return function () {
        var idx = gen();
        if (idx !== undefined) {
            return ary[idx];
        }
    };
}

var ele = element(['a', 'b', 'c', 'd']);

console.log(ele()); // a
console.log(ele()); // b
console.log(ele()); // c
console.log(ele()); // d
console.log(ele()); // undefined 


/// Challenge 5

function collect(gen, ary) {
    return function () {
        var res = gen();
        if (res !== undefined) {
            ary.push(res);
        }
        return res;
    };

}

var array = [],
    col = collect(fromTo(0, 2), array);

console.log(col()); // 0
console.log(col()); // 1
console.log(col()); // undefined
console.log(array); // [0,1]


function filter(gen, pred) {
    return function () {
        var value = gen();
        while (value !== undefined && !pred(value)) {
            value = gen();
        }
        return value;
    };
}


// es6 - tail call optimization!
function filter(gen, pred) {
    return function recur() {
        var value = gen();
        if (value === undefined || pred(value)) {
            return value;
        }
        return recur();
    };
}


var fil = filter(fromTo(0, 5), function third(value) {
    return (value % 3) === 0;
});

console.log(fil()); // 0
console.log(fil()); // 3
console.log(fil()); // undefined/


function concat(g1, g2) {
    var gen = g1;
    return function () {
        var val = gen();
        while (val !== undefined) {
            return val;
        }
        gen = g2;
        return gen();
    };
}

// es6
// function concat(...gens) {
//     var next = element(gens),
//         gen = next();
//
//     function recur() {
//         var value = gen();
//         if (value === undefined) {
//             gen = next();
//             if (gen !== undefined) {
//                 return recur();
//             }
//         }
//         return value;
//     }
//
// }

var con = concat(fromTo(0,3), fromTo(0, 2));
console.log('\nconcat\n');
console.log(con()); // 0
console.log(con()); // 1
console.log(con()); // 2
console.log(con()); // 0
console.log(con()); // 1
console.log(con()); // undefined


// challenge 6

function gensymf(char) {
    var idx = 0;

    return function() {
        idx += 1;
        return char + idx;
    }
}


console.log('\ngensymf\n');

var geng = gensymf('G'),
    genh = gensymf('H');

console.log(geng()); // G1
console.log(genh()); // H1
console.log(geng()); // G2
console.log(genh()); // H2


function fibonaccif(a, b) {
    var cnt = 0;
    return function() {
        var next;
        if (cnt < 1) {
            cnt += 1;
            return a;
        }

        if (cnt < 2) {
            cnt += 1;
            return b;
        }

        next = a + b;
        a = b;
        b = next;
        return next;
    };

}

function fibonaccif(a,b) {
    return function() {
        var next = a;
        a = b;
        b += next;
        return next;
    };
}

function fibonaccif(a,b) {
    return concat(
        concat(
            limit(identityf(a), 1),
            limit(identityf(b), 1)
        ), function fibonnaci() {
            var next = a + b;
            a = b;
            b = next;
            return next;
        }
    );
}

function fibonaccif(a,b) {
  return concat(
    element([a,b]),
    function fibonacci() {
      var next = a + b;
      a = b;
      b = next;
      return next;
    }
  );
}

var fib = fibonaccif(0, 1);
console.log('fibonaccif'); //0


// challenge 7
function counter(i) {
  return {
    up: function() {
      i += 1;
      return i;
    },
    down: function() {
      i -= 1;
      return i;
    },
  };
}


var object = counter(10),
        up = object.up,
      down = object.down;

console.log(up()); // 11
console.log(down()); // 10
console.log(down()); // 9
console.log(up()); // 10


console.log('\nrevocable\n');

function revocable(f) {
  var invocable = true;
  return {
    invoke: function(a,b) {
        if (invocable) {
          return f(a,b);
        }
        return undefined;
    },

    revoke: function() {
      invocable = false;
    }
  };
}

function revocable(binary) {
  return {
    invoke: function(a,b) {
        if (binary !== undefined) {
          return binary(a,b);
        }
        return undefined;
    },

    revoke: function() {
      binary = undefined;
    }
  };
}


var rev = revocable(add);
add_rev = rev.invoke;

console.log(add_rev(3,4)); // 7
rev.revoke();
console.log(add_rev(5,7)); // undefined

// challenge 8

console.log('\nm\n');

function m(val, s) {
  return {
    value: val,
    source: (typeof s === 'string') ? s : String(val)
  };
}

console.log(JSON.stringify(m(1))); // {"value": 1, "source": "1"}
console.log(JSON.stringify(m(Math.PI, "pi"))); // {"value": 3.14159..., "source": "pi"}


console.log('\naddm\n');

function addm(m1, m2) {
  return m(
    m1.value + m2.value,
    '('+ m1.source + '+' + m2.source + ')'
  );
}

console.log(JSON.stringify(addm(m(3), m(4)))); // {"value": 7, "source": "(3+4)"}"
console.log(JSON.stringify(addm(m(1), m(Math.PI, "pi")))); // {"value": 4.141.59.., "source": "(1+pi)"}"


console.log('\nliftmm\n');

// this is a monad!
function liftm(binary, op) {
  return function(m1,m2) {
    return m(
      binary(m1.value, m2.value),
      '('+ m1.source + op + m2.source + ')'
    );
  };

}

var addm = liftm(add, "+");

console.log(JSON.stringify(addm(m(3), m(4))));
// {"value": 7, "source": "(3+4)"}"
console.log(JSON.stringify(liftm(mul, "*")(m(3), m(4))));
// {"value": 12, "source": "(3*4)"}

console.log('\nmodify liftmm\n');



function liftm(binary, op) {
  return function(m1,m2) {
    if (typeof m1 === 'number') {
      m1 = m(m1);
    }

    if (typeof m2 === 'number') {
      m2 = m(m2);
    }
    return m(
      binary(m1.value, m2.value),
      '('+ m1.source + op + m2.source + ')'
    );
  };

}

var addm = liftm(add, "+");

console.log(JSON.stringify(addm(3, 4))); 
// {"value": 7, "source": "(3+4)"}


console.log('\nexp\n');

function exp(value) {
    return (Array.isArray(value)) ? value[0](value[1], value[2]) : value;
}

var sae = [mul, 5, 11];
console.log(exp(sae)); // 55
console.log(exp(42)); // 42


console.log('\nnested exp\n');


function exp(value) {

    var op = value[0];

    var a;
    var b;

    if (Array.isArray(value[1]) && value.length > 1) {
       a = exp(value[1]);
    } else {
        a = value[1];
    }

    if (Array.isArray(value[2]) && value.length > 2) {
        b = exp(value[2]);
    } else {
        b = value[2];
    }

    if (a !== undefined && b !== undefined) {
        return op(a, b);
    }

    if (a !== undefined) {
        return op(a);
    }

}

function exp(value) {
   return (Array.isArray(value)) ?
       value[0](
           exp(value[1]),
           exp(value[2])
       )
       : value;
}

function square(x) {
    return x * x;
}

var nae = [
    Math.sqrt,
    [
        add,
        [square, 3],
        [square, 4]
    ]
];

console.log(exp(nae)); // 5



console.log('\naddg\n');


function addg(result) {
    if (result === undefined) {
        return;
    }

    return function recur(next) {
        if (next === undefined) {
            return result;
        }
        result += next;
        return recur;
    };
}

// retursion!
function addg(first) {
    function more(next) {
        if (next === undefined) {
            return first;
        }
        first += next;
        return more;
    }

    if (first !== undefined) {
        return more;
    }
}


console.log(addg());                // undefined
console.log(addg(2)());             // 2
console.log(addg(2)(7)());          // 9
console.log(addg(3)(0)(4)());       // 7
console.log(addg(1)(2)(4)(8)());    // 15

console.log('\nliftg\n');

function liftg(op) {

    return function(res) {

        function more(next) {
            if (next === undefined) {
                return res;
            }
            res = op(res, next);
            return more;
        }

        if (res !== undefined) {
            return more;
        }
    };
}

function liftg(binary) {
    return function(first) {
        if (first === undefined) {
            return first;
        }

        return function more(next) {
            if (next === undefined) {
                return first;
            }
            first = binary(first, next);
            return more;
        }

    };

}

console.log(liftg(mul)());             // undefined
console.log(liftg(mul)(3)());          // 3
console.log(liftg(mul)(3)(0)(4)());    // 0
console.log(liftg(mul)(1)(2)(4)(8)()); // 64



function liftg(op) {

    return function(res) {

        function more(next) {
            if (next === undefined) {
                return res;
            }
            res = op(res, next);
            return more;
        }

        if (res !== undefined) {
            return more;
        }
    };
}

function liftg(binary) {
    return function(first) {
        if (first === undefined) {
            return first;
        }

        return function more(next) {
            if (next === undefined) {
                return first;
            }
            first = binary(first, next);
            return more;
        }

    };

}

console.log(liftg(mul)());             // undefined
console.log(liftg(mul)(3)());          // 3
console.log(liftg(mul)(3)(0)(4)());    // 0
console.log(liftg(mul)(1)(2)(4)(8)()); // 64



console.log('\narrayg\n');

function arrayg(first) {
    if (first === undefined) {
        return [];
    }
    var res = [first];

    return function more(next) {
        if (next === undefined) {
            return res;
        }
        res.push(next);

        return more;
    }
}

function arrayg(first) {
    var array = [];
    function more(next) {
        if (next === undefined) {
            return array;
        }

        array.push(next);
        return more;
    }
    return more(first);
}


function arrayg(first) {
   if (first === undefined) {
       return [];
   }
   return liftg(
       function (array, value) {
           array.push(value);
           return array;
       }
   )([first]);
}




console.log(arrayg());              // []
console.log(arrayg(3)());           // [3]
console.log(arrayg(3)(4)(5)());     // [3, 4, 5]


console.log('\ncontinuize\n');

function continuize(unary) {
    return function(callback, arg) {
        callback(unary(arg));
    }
}

// es6
// function continuize(any) {
//     return function(callback, ...x) {
//         return callback(any(...x));
//     };
// }


sqrtc = continuize(Math.sqrt);
sqrtc(console.log, 81); // 9



console.log('\nMake an array wrapper object to prevent access to private array\n');

myvector = vector();

function vector() {
    var array = [];

    return {
        get: function get(i) {
            return array[i];
        },
        store: function store(i, v) {
            array[i] = v;
        },
        append: function append(v) {
            array.push(v);
        }
    };
}

function vector() {
    var array = [];
    return {
        get: function get(i) {
            return array[+i];
        },
        store: function store(i,v) {
            array[+i] = v;
        },
        append: function append(v) {
            array[array.length] = v;
        }
    };
}

myvector.append(7);
myvector.store(1,8);
console.log(myvector.get(0)); // 7
console.log(myvector.get(1)); // 8

var stash;
myvector.store('push', function() {stash = this;});


console.log('\nMake a function that makes a pub/sub object\n');

function mypubsub() {
    var subscribers = [];
    return {
        subscribe: function (sub) {
            subscribers.push(sub);
        },

        publish: function (msg) {
            subscribers.forEach(function (sub) {
                sub(msg);
            });
        }
    };
}


my_pubsub = pubsub();
my_pubsub.subscribe(console.log);
my_pubsub.publish('It works!');



function pubsub() {
    var subscribers = [];
    return {
        subscribe: function (sub) {
            subscribers.push(sub);
        },

        publish: function (msg) {
            var i, length = subscribers.length;
            for (i = 0; i < length; i += 1) {
                subscribers[i](msg);
            }
        }
    };
}

// stop all subscribers from getting messages
// - `undefined` will be a subscription, and fail in the loop
my_pubsub.subscribe();

// fix with try-catch
function pubsub() {
    var subscribers = [];
    return {
        subscribe: function (sub) {
            subscribers.push(sub);
        },

        publish: function (msg) {
            var i, length = subscribers.length;
            for (i = 0; i < length; i += 1) {
                try {
                    subscribers[i](msg);
                } catch (ignore) {}
            }
        }
    };

}

// tamper with the pubsub methods
my_pubsub.publish = undefined;


// fix with Object.freeze
function pubsub() {
    var subscribers = [];
    return Object.freeze({
        subscribe: function (sub) {
            subscribers.push(sub);
        },

        publish: function (msg) {
            var i, length = subscribers.length;
            for (i = 0; i < length; i += 1) {
                try {
                    subscribers[i](msg);
                } catch (ignore) {}
            }
        }
    });
}

// access subscribers array
my_pubsub.subscribe(function() {
    this.length = 0;
});


// fix with a variable.  avoids method invocation
function pubsub() {
    var subscribers = [];
    return Object.freeze({
        subscribe: function (sub) {
            subscribers.push(sub);
        },

        publish: function (msg) {
            subscribers.forEach(function(sub){
                try {
                    sub(msg);
                } catch (ignore) {}
            });
        }
    });
}

new_pubsub = pubsub();
new_pubsub.subscribe(function (msg) {
    console.log(this);
});

new_pubsub.publish('test');


// attacker sends own message out of order

// need 'limit', or else, its just a denial of service attack.
my_pubsub.subscribe(limit(function() {
    my_pubsub.publish("Out of order");
}, 1));


// fix: line up callbacks in timer queue
// - now, all subscriber will get first publish message before the next `publish` call

// - no need for `try-catch` now since if it fails, it only fails in that `turn`.
// - unfortunately w/ setTimeout, attacker can guess the Number returned from the function, and `clearTimeout`,
//  thus preventing a subscriber from getting a message.

function pubsub() {
    var subscribers = [];
    return Object.freeze({
        subscribe: function (sub) {
            subscribers.push(sub);
        },

        publish: function (msg) {
            subscribers.forEach(function(sub){
                setTimeout(function() {
                   sub(msg);
                }, 0);
            });
        }
    });
}

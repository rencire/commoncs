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

var fib = fibonaccif(0, 1);
console.log('fibonaccif'); //0

console.log(fib()); //0
console.log(fib()); //1
console.log(fib()); //1
console.log(fib()); //2
console.log(fib()); //3
console.log(fib()); //5


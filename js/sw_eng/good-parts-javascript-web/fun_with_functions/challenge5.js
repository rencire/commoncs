

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

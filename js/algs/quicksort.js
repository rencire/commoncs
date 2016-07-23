// [1,2,4,3,5,7,8]
// pivot = 5
//
// [1,3,6,8,0,9,2]


var qsort = function(a, low, high) {
    var p;
    if(high > low) {
        p = partition(a, low, high);
        qsort(a, low, p-1);
        qsort(a, p+1, high);
    }
}

var partition = function(a, low, high) {
    var p;
    var firstHigh;

    p = high; //consider picking pivot to be random instead?

    firstHigh = low;
    for(var i = low; i < high; i++) {
        if(a[i] < a[p]) {
            var tmp = a[firstHigh];
            a[firstHigh] = a[i];
            a[i] = tmp;
            firstHigh++;
        }
    }
    var tmp = a[firstHigh];
    a[firstHigh] = a[p];
    a[p] = tmp;

    return firstHigh;
}

// a = [2,3,1,3];
// console.log(a);
// qsort(a, 0, 3);
// console.log(a);


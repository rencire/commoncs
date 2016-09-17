function constructor(init) {
    var that = other_constructor(init),
        member,
        method = function () {
            // init, member, method
        };

    that.method = method;
    return that;
}

// es6
// - `let {member}` is shorthand for `let member = spec.member`
// - the obj `{method, other}` is shorthand for the obj `{method: method, other: other}`
function constructor(spec) {
    let {member} = spec;
    const {other} = other_constructor(spec);
    const method = function() {
        // spec, member, other, method
    };

    return Object.freeze({
        method,
        other
    });

}
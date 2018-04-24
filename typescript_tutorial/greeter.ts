function greeter(person: string) {
    return "Hello, " + person;
}

let user = "Jane User";

document.body.innerHTML = greeter(user);

// function greeter(person: string) {
//     return "Hello, " + person;
// }
//
// let user = [0, 1, 2];
//
// document.body.innerHTML = greeter(user);

// $ tsc greeter.ts
// greeter.ts(15,35): error TS2345: Argument of type 'number[]' is not assignable to parameter of type 'string'.

// 上の例は、引数の方がstringに指定されているが、arrayを入れようといているのでエラーになる


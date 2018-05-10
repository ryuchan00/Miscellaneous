function triangle(base: number, height: number):
    number {
    return base * height / 2;
}

console.log(triangle(10, 5));

console.log('関数リテラルを使用するとこんな感じ');
let triangle2 = function (base: number, height: number):
    number {
    return base * height / 2;
};

console.log(triangle2(10, 5));   // 25

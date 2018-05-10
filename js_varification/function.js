function triangle(base, height) {
    return base * height / 2;
}
console.log(triangle(10, 5));
console.log('関数リテラルを使用するとこんな感じ');
var triangle2 = function (base, height) {
    return base * height / 2;
};
console.log(triangle2(10, 5)); // 25

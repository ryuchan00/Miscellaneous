function triangle(base, height) {
    return base * height / 2;
}
console.log(triangle(10, 5));
console.log('関数リテラルを使用するとこんな感じ');
var triangle2 = function (base, height) {
    return base * height / 2;
};
console.log(triangle2(10, 5)); // 25
console.log('型を明示するならアローを使う書き方');
//               借り引数                         戻り値　の型
var triangle3 = function (base, height) {
    return base * height / 2;
};
console.log(triangle3(10, 5)); // 25
var triangle4 = function (base, height) {
    return base * height / 2;
};
console.log(triangle4(10, 5)); // 25
console.log('簡素化した場合');
// 関数の本体が1文である場合には、中かっこは省略できます。
var triangle5 = function (base, height) { return base * height / 2; };
console.log(triangle5(10, 5));
var Counter = function () {
    // 現在のthisを退避
    console.log(this);
    var _this = this;
    _this.count = 0;
    // 1000ms感覚でcountプロバティをインクリメント
    // setInterval(function () {
    //     console.log(this);
    //     _this.count++;
    // }, 1000);
};
Counter();
console.log('省略可能な引数を宣言する');
// 借り引数の名前に'?'をつけると、任意という意味になる
function showTime(time) {
    // 引数timeが省略された場合は現在時刻を出力
    if (time === undefined) {
        return '現在時刻:' + (new Date()).toLocaleString();
    }
    else {
        return '現在時刻:' + time.toLocaleString;
    }
}
console.log(showTime());
console.log('引数にデフォルト値を設定する');
function showTime2(time) {
    if (time === void 0) { time = new Date(); }
    return '現在時刻:' + time.toLocaleString();
}
console.log(showTime());
console.log('不特定多数の引数を表現する -可変長引数');
function sum() {
    var values = [];
    for (var _i = 0; _i < arguments.length; _i++) {
        values[_i - 0] = arguments[_i];
    }
    var result = 0;
    // 配列の内容を順に足しこむ
    for (var _a = 0, values_1 = values; _a < values_1.length; _a++) {
        var value = values_1[_a];
        result += value;
    }
    return result;
}
console.log(sum(1, 5, -8, 10)); // 8
console.log('関数のオーバーロード');
function show(value) {
    // number型の場合
    if (typeof value === 'number') {
        console.log(value.toFixed(0));
    }
    else {
        console.log(value ? '真' : '偽');
    }
}
show(10.358); // 10
show(false); // 偽
// show('ほげ'); // エラー
console.log('引数/戻り値型としての共用型');
function square(value) {
    if (value < 0) {
        return false;
    }
    else {
        return Math.sqrt(value);
    }
}
console.log(square(9)); // 2
console.log(square(-9)); // false
console.log('型ガード');
// 変数の型を判定することで、対象となった変数の型を特定する仕組みのこと。
function process(value) {
    if (typeof value === 'string') {
        return value.toUpperCase();
    }
    else {
        return value.toFixed(0);
    }
}
console.log(process('superman'));
console.log(process(10));

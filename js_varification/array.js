// 基本的な値の集合を表す - 配列
var data = ['Java', 'Python', 'PHP', 'Ruby'];
console.log(data[0]);
// こういう書き方もできるが、あえて利用することもない
var data2 = ['Java', 'Python', 'PHP', 'Ruby'];
// 多次元配列
var data3 = [[10, 20], [30, 40], [50, 60]];
console.log(data3[1][1]); // 40
var obj = {
    'hoge': 'ほげ',
    'foo': 'ふー',
    'bar': 'ばー',
};
// 1.プロパティ構文
console.log(obj.hoge); // 結果: ほげ
// 2.ブラケット構文
console.log(obj['hoge']); // 結果: ほげ
// 関係する定数を束ねる列挙型
var Sex;
(function (Sex) {
    Sex[Sex["MALE"] = 0] = "MALE";
    Sex[Sex["FEMALE"] = 1] = "FEMALE";
    Sex[Sex["UNKNOWN"] = 2] = "UNKNOWN";
})(Sex || (Sex = {}));
// 1. MALEにアクセス
var m = Sex.MALE;
console.log(m); // 0
console.log(Sex[m]); // MALE
// 複数の型が混在したタプル型
// Tuple(タプル)とは、複数の異なる型の集合を表現するためのデータ型です。
var data4 = ['hoge', 10.355, false];
console.log(data4[0].substring(2)); // ge
console.log(data4[1].toFixed(1)); // 10.4
console.log(data4[2] === false); // true
// タプルはこういう面があるのでよくない
// data4.shift();
// console.log(data[0].substring(2));  // エラー
// 共用型
var data5;
data5 = 'hoge'; // 1. OK
data5 = false; // 2. OK
// data5 = 1; // 3. エラー
console.log('--型エイリアス--');
// FooType型の変数dataを定義
// let data6: FooType = ['abc', 'xyz', true];
console.log('--文字列リテラル--');
// Season型の引数を受け取るgetScene関数
function getScene(s) {
    // 引数sに応じた処理を実装
    console.log(s);
}
getScene('spring'); // OK
// getScene('fail');       // 2. エラー
var data6 = undefined;
var data7 = null;

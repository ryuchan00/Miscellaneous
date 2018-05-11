var Person = (function () {
    // コンストラクター
    function Person(name, sex) {
        this.name = name;
        this.sex = sex;
    }
    // メソッド
    Person.prototype.show = function () {
        return this.name + "\u306F" + this.sex + "\u3067\u3059\u3002";
    };
    return Person;
}());
var p = new Person('りお', '女');
console.log(p.show());
//  この構成は、Java/C#などでオブジェクト指向構文を学んだことがある人であれば直感的に理解できる内容
console.log('クラスの内外からアクセスを制御する アクセス修飾子');
var Person2 = (function () {
    // コンストラクター(プロパティを初期化)
    function Person2(name, sex) {
        this.name = name;
        this.sex = sex;
    }
    // 3. privateプロパティにもアクセス可能
    Person2.prototype.show = function () {
        // 2. クラス内からアクセス可能
        return this.name + "\u306F" + this.sex + "\u3067\u3059";
    };
    return Person2;
}());
var p2 = new Person2('真央', '女');
console.log(p2.show());
console.log('コンストラクターとプロパティ設定');
var Person3 = (function () {
    // シンプルに書くとしたらこんな感じ
    function Person3(name, sex) {
        this.name = name;
        this.sex = sex;
    }
    // 3. privateプロパティにもアクセス可能
    Person3.prototype.show = function () {
        // 2. クラス内からアクセス可能
        return this.name + "\u306F" + this.sex + "\u3067\u3059";
    };
    return Person3;
}());
var p3 = new Person3('まりな', '女');
console.log(p3.show());
console.log('getter/setterアクセサー');
// privateプロパティにアクセスするための特別なメソッドです。
var Person4 = (function () {
    function Person4() {
    }
    return Person4;
}());

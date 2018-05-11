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
// 利点
// - 読み書きができる
// - 値チェック/戻り値の加工などが可能
var Person4 = (function () {
    function Person4() {
    }
    Object.defineProperty(Person4.prototype, "age", {
        // getterアクセサー
        get: function () {
            return this._age;
        },
        // setterアクセサー
        set: function (value) {
            if (value < 0) {
                throw new RangeError('ageプロパティは正数で指定してください');
            }
            this._age = value;
        },
        enumerable: true,
        configurable: true
    });
    return Person4;
}());
var p4 = new Person4();
p4.age = 10;
console.log(p4.age);
console.log('静的メンバー');
var Figure = (function () {
    function Figure() {
    }
    // 静的メソッドcircle(園の面積)
    Figure.circle = function (radius) {
        // 静的メンバーにアクセスする際にも、thisを明示的にしなくてはならない
        return radius + radius + this.Pi;
    };
    // 静的プロパティPi(円周率)
    Figure.Pi = 3.14159;
    return Figure;
}());
console.log(Figure.Pi);
console.log(Figure.circle(5));

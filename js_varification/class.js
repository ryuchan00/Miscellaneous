var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
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
console.log('名前空間');
// Typescriptは、デフォルトで名前空間は以下の要素へのアクセスを許可しません。
// exportキーワードで、外からのアクセスが可能であることを明示的に宣言してください。
// 1. MainApp名前空間を定義
var MainApp;
(function (MainApp) {
    var Hoge = (function () {
        function Hoge(value) {
            this.value = value;
            console.log(this.value);
        }
        return Hoge;
    }());
    MainApp.Hoge = Hoge;
    function foo() {
        console.log('MainApp function');
    }
    MainApp.foo = foo;
})(MainApp || (MainApp = {}));
// 2.名前空間配下のクラス/関数の呼び出し
var h = new MainApp.Hoge('rubykaigi2018 !!');
MainApp.foo();
console.log('階層的な名前空間');
var Wings;
(function (Wings) {
    var MainApp;
    (function (MainApp) {
        var Hoge = (function () {
            function Hoge() {
            }
            return Hoge;
        }());
        MainApp.Hoge = Hoge;
        function foo() {
        }
        MainApp.foo = foo;
    })(MainApp = Wings.MainApp || (Wings.MainApp = {}));
})(Wings || (Wings = {}));
var h2 = new Wings.MainApp.Hoge();
Wings.MainApp.foo();
console.log('namespaceを入れ子にする');
var Wings;
(function (Wings) {
    var MainApp;
    (function (MainApp) {
        var Hoge2 = (function () {
            function Hoge2() {
            }
            return Hoge2;
        }());
        MainApp.Hoge2 = Hoge2;
        function foo2() {
        }
        MainApp.foo2 = foo2;
    })(MainApp = Wings.MainApp || (Wings.MainApp = {}));
})(Wings || (Wings = {}));
console.log('継承/実装');
console.log('オーバーライド');
var Person5 = (function () {
    // コストラクター(name/sexプロパティの初期化)
    function Person5(name, sex) {
        this.name = name;
        this.sex = sex;
    }
    Person5.prototype.show = function () {
        return this.name + "\u306F" + this.sex + "\u3067\u3059";
    };
    // オーバーライドの実験用、BusinessPersonクラスに継承された時に上書きされるはず
    Person5.prototype.work = function () {
        return this.name + "\u306F\u5168\u304F\u50CD\u304D\u307E\u305B\u3093";
    };
    return Person5;
}());
// Personクラスを継承したBusinessPersonクラスを定義
var BusinessPerson = (function (_super) {
    __extends(BusinessPerson, _super);
    // コンストラクターをオーバーライド
    function BusinessPerson(name, sex, clazz) {
        _super.call(this, name, sex);
        this.clazz = clazz;
    }
    // 1. 派生クラス独自のメソッドを定義
    BusinessPerson.prototype.show = function () {
        return _super.prototype.show.call(this) + (this.clazz + "\u3067\u3059");
    };
    BusinessPerson.prototype.work = function () {
        return this.name + "\u306F\u30C6\u30AD\u30D1\u30AD\u50CD\u304D\u307E\u3059\u3002";
    };
    return BusinessPerson;
}(Person5));
var p5 = new BusinessPerson('りお', '女', 'super engineer');
console.log(p5.show());
console.log(p5.work());
console.log('抽象クラス');
// 2. 抽象クラスを宣言
var Figure2 = (function () {
    function Figure2(width, height) {
        this.width = width;
        this.height = height;
    }
    return Figure2;
}());
var Triangle = (function (_super) {
    __extends(Triangle, _super);
    function Triangle() {
        _super.apply(this, arguments);
    }
    // 抽象メソッドをオーバーライド
    Triangle.prototype.getArea = function () {
        return this.width + this.height / 2;
    };
    return Triangle;
}(Figure2));
var t2 = new Triangle(10, 5);
console.log(t2.getArea());
console.log('インターフェース');

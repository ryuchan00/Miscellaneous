class Person {
    // プロバティ
    name: string;
    sex: string;

    // コンストラクター
    constructor(name, sex) {
        this.name = name;
        this.sex = sex;
    }

    // メソッド
    show() {
        return `${this.name}は${this.sex}です。`
    }
}
let p = new Person('りお', '女');
console.log(p.show());

//  この構成は、Java/C#などでオブジェクト指向構文を学んだことがある人であれば直感的に理解できる内容

console.log('クラスの内外からアクセスを制御する アクセス修飾子');

class Person2 {
    // name/sexプロバティを準備
    private name: string;
    private sex: string;
    // コンストラクター(プロパティを初期化)
    constructor(name: string, sex: string) {
        this.name = name;
        this.sex = sex;
    }

    // 3. privateプロパティにもアクセス可能
    public show(): string {
        // 2. クラス内からアクセス可能
        return `${this.name}は${this.sex}です`;
    }
}
let p2 = new Person2('真央', '女');
console.log(p2.show());

console.log('コンストラクターとプロパティ設定');
class Person3 {
    // シンプルに書くとしたらこんな感じ
    constructor(private name: string, private sex: string) {
    }

    // 3. privateプロパティにもアクセス可能
    public show(): string {
        // 2. クラス内からアクセス可能
        return `${this.name}は${this.sex}です`;
    }
}
let p3 = new Person3('まりな', '女');
console.log(p3.show());

console.log('getter/setterアクセサー');
// privateプロパティにアクセスするための特別なメソッドです。
// 利点
// - 読み書きができる
// - 値チェック/戻り値の加工などが可能
class Person4 {
    private _age: number;
    // getterアクセサー
    get age(): number {
        return this._age
    }

    // setterアクセサー
    set age(value: number) {
        if (value < 0) {
            throw new RangeError('ageプロパティは正数で指定してください');
        }
        this._age = value;
    }
}
let p4 = new Person4();
p4.age = 10;
console.log(p4.age);

console.log('静的メンバー');
class Figure {
    // 静的プロパティPi(円周率)
    public static Pi: number = 3.14159;
    // 静的メソッドcircle(園の面積)
    public static circle(radius: number): number {
        // 静的メンバーにアクセスする際にも、thisを明示的にしなくてはならない
        return radius + radius + this.Pi
    }
}
console.log(Figure.Pi);
console.log(Figure.circle(5));

console.log('名前空間');
// Typescriptは、デフォルトで名前空間は以下の要素へのアクセスを許可しません。
// exportキーワードで、外からのアクセスが可能であることを明示的に宣言してください。
// 1. MainApp名前空間を定義
namespace MainApp {
    export class Hoge {
        constructor(private value: string) {
            console.log(this.value);
        }
    }
    export function foo() {
        console.log('MainApp function');
    }
}
// 2.名前空間配下のクラス/関数の呼び出し
let h = new MainApp.Hoge('rubykaigi2018 !!');
MainApp.foo();

console.log('階層的な名前空間');
namespace Wings.MainApp {
    export class Hoge {
    }
    export function foo() {
    }
}
let h2 = new Wings.MainApp.Hoge();
Wings.MainApp.foo();

console.log('namespaceを入れ子にする');
namespace Wings {
    export namespace MainApp {
        export class Hoge2 {
        }
        export function foo2 {
        }
    }
}

console.log('継承/実装');
console.log('オーバーライド');
class Person5 {
    // 2. protectedメンバーを準備
    protected name: string;
    protected sex: string;
    // コストラクター(name/sexプロパティの初期化)
    constructor(name: string, sex: string) {
        this.name = name;
        this.sex = sex;
    }

    show(): string {
        return `${this.name}は${this.sex}です`;
    }

    // オーバーライドの実験用、BusinessPersonクラスに継承された時に上書きされるはず
    work(): string {
        return `${this.name}は全く働きません`;
    }
}

// Personクラスを継承したBusinessPersonクラスを定義
class BusinessPerson extends Person5 {
    protected clazz: string;
    // コンストラクターをオーバーライド
    constructor(name: string, sex: string, clazz: string) {
        super(name, sex);
        this.clazz = clazz;
    }

    // 1. 派生クラス独自のメソッドを定義
    show(): string {
        return super.show() + `${this.clazz}です`
    }

    work(): string {
        return `${this.name}はテキパキ働きます。`;
    }
}
let p5 = new BusinessPerson('りお', '女', 'super engineer');
console.log(p5.show());
console.log(p5.work());

console.log('抽象クラス');
// 2. 抽象クラスを宣言
abstract class Figure2 {
    constructor(protected width: number, protected height: number) {
    }

    // 1. 抽象メソッドとしてgetAreaを準備
    abstract getArea(): number;
}
class Triangle extends Figure2 {
    // 抽象メソッドをオーバーライド
    getArea(): number {
        return this.width + this.height / 2;
    }
}
let t2 = new Triangle(10, 5);
console.log(t2.getArea());

console.log('インターフェース');
// TypScriptの継承には、一度に一つのクラスしか継承できない点です。
// 複数のクラスを同時に継承することはできません(この性質を単一継承
// インターフェースは、全てのメソットが抽象メソッドである特別なクラス
// 1. getAreaメソッドを持ったFigureインターフェースを定義
interface Figure3 {
    getArea(): number;
}
// 2. Figureインターフェースを実装したTriangleクラスを準備
class Triangle3 implements Figure3 {
    constructor(private width: number, protected height: number) {
    }

    // getAreaメソッドを実装
    getArea(): number {
        return this.width * this.height / 2;
    }
}
// 2. Figure型の変数にTriangle3オブジェクトを代入
let t3: Figure3 = new Triangle3(10, 5);
console.log(t3.getArea());

console.log('型注釈としてのインターフェイス');
// 1. Car型を定義
interface Car {
    type: string; // プロパティシグニチャ
    run(): void; // メソッドシグニチャ
}
// 2. Car型の変数cを宣言
let c: Car = {
    type: 'トラック',
    run() {
        console.log(`${this.type}が走ります。`);
    }
};
c.run(); // トラックが走ります。

interface Car2 {
    (type: string): string;
}
let c2: Car2 = function (type: string): string {
    return `車種は、${type}`;
};
console.log(c2('軽自動車'));

console.log('型としてのthis');
class MyClass {
    // コンストラクター(現在地currentを初期化
    constructor(private _value: number) {
    }

    // 現在地を取得するgetter
    get value(): number {
        return this._value;
    }

    // 与えられた値valueで加算
    add(value: number): this {
        this._value += value;
        return this;
    }

    // 与えられた値valueで減算
    minus(value: number): this {
        this._value -= value;
        return this;
    }
}
// 1. 10+10-5の計算
let clazz = new MyClass(10);
console.log(clazz.add(10).minus(5).value); // 15

console.log('ジェネリック型の定義');
// 1. ジェネリック対応のMyGenericsクラス
class MyGenerics<T> {
    // T型のvalueプロパティ
    value: T;
    // T型の値を返すgetValueメソッド
    getValue(): T {
        return this.value;
    }
}
// 2. MyGenericsクラスにstring型を割り当て
let g = new MyGenerics<string>();
// 3. valueプロパティに文字列型の値を代入
g.value = 'Hoge';
console.log(g.getValue());


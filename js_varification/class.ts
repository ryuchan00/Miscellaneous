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
class Person4 {
    private _age: number;
    //
}
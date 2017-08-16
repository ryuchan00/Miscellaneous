<?php
$keyword_uppercase = 'XYZ';
$keyword_lowercase = 'xyz';

$text1 = 'abcXYZ';
$text2 = 'abcXYZabcXYZ';

// mb_strposの挙動

// 大文字は文字は含まれていると判定される
if (mb_strpos($text1, $keyword_uppercase) === false) {
    echo $keyword_uppercase . "は含まれていません" . "\n";
} else {
    echo $keyword_uppercase . "は含まれています" . "\n";
    echo mb_strpos($text1, $keyword_uppercase) . "文字目" . "\n";
}

// 小文字は含まれていないと判定される
if (mb_strpos($text1, $keyword_lowercase) === false) {
    echo $keyword_lowercase . "は含まれていません" . "\n";
} else {
    echo $keyword_lowercase . "は含まれています" . "\n";
    echo mb_strpos($text1, $keyword_lowercase) . "文字目" . "\n";
}

// 検索対象の文字列の中に、キーワードが複数含まれていても最初にマッチングした位置を返す
if (mb_strpos($text2, $keyword_uppercase) === false) {
    echo $keyword_uppercase . "は含まれていません" . "\n";
} else {
    echo $keyword_uppercase . "は含まれています" . "\n";
    echo mb_strpos($text1, $keyword_uppercase) . "文字目" . "\n";
}

// mb_striposの挙動

// 大文字は文字は含まれていると判定される
if (mb_stripos($text1, $keyword_uppercase) === false) {
    echo $keyword_uppercase . "は含まれていません" . "\n";
} else {
    echo $keyword_uppercase . "は含まれています" . "\n";
    echo mb_stripos($text1, $keyword_uppercase) . "文字目" . "\n";
}

// 小文字も文字は含まれていると判定される
if (mb_stripos($text1, $keyword_lowercase) === false) {
    echo $keyword_lowercase . "は含まれていません" . "\n";
} else {
    echo $keyword_lowercase . "は含まれています" . "\n";
    echo mb_stripos($text1, $keyword_lowercase) . "文字目" . "\n";
}


// mbstrposの誤判定
$keyword2 = 'DEF';

$text2 = 'DEFghi';

// 含まれていないと判定される
// mb_strposの戻り値が'0'の場合、誤判定するため
// mb_strposの判定は'==='で行うこと
if (mb_strpos($text2, $keyword2) == false) {
    echo $keyword2 . "は含まれていません" . "\n";
    echo mb_strpos($text2, $keyword2) . "文字目" . "\n";
} else {
    echo $keyword2 . "は含まれています" . "\n";
}

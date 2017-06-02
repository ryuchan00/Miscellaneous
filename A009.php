<?php
//A009 ビームの反射
//テストケース全パス
//もう少しスマートに書けないか検討中です
//柴田和樹、中野大輝
$num = str_replace("\n", "", explode(" ",fgets(STDIN)));
for($i = 0; $i < $num[0]; $i++){
    $box[$i] = str_replace("\n", "", str_split(fgets(STDIN)));
}
$x = 0;
$y = 0;
$cnt = 0;
$beam = 0;
while( 0<= $x && $x < $num[1] && 0 <= $y && $y < $num[0]){
    if($box[$y][$x] === "\\"){
        if($beam === 0){
            $beam = 3;
        } elseif($beam === 1){
            $beam = 2;
        } elseif($beam === 2){
            $beam = 1;
        } elseif($beam === 3){
            $beam = 0;
        }
    } elseif($box[$y][$x] === '/'){
        if($beam === 0){
            $beam = 2;
        } elseif($beam === 1){
            $beam = 3;
        } elseif($beam === 2){
            $beam = 0;
        } elseif($beam === 3){
            $beam = 1;
        }
    }
    if($beam === 0){
        $x++;
    } elseif($beam === 1){
        $x--;
    } elseif($beam === 2){
        $y--;
    } elseif($beam === 3){
        $y++;
    }
    $cnt++;
}
echo $cnt."\n";
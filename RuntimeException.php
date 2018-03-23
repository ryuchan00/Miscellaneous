<?php

// [PHP: RuntimeException - Manual](http://php.net/manual/ja/class.runtimeexception.php)
// throwの後の処理を実行するか忘れたので、実験
$iNum1 = 10;
$iNum2 = 0;
#$iNum2 = 1;

try{
if ($iNum2 == 0){
throw new RuntimeException("Division by Zero");
}
$iResult = $iNum1 / $iNum2;
echo ("Division Result of \$iNum1 and $iNum2 = ".($iResult).PHP_EOF);
}
catch (RuntimeException $e){
echo ("Division by Zero is not possible");
}
echo "after cathc block.";

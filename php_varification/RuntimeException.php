<?php

// [PHP: RuntimeException - Manual](http://php.net/manual/ja/class.runtimeexception.php)
// throwの後の処理を実行するか忘れたので、実験
$iNum1 = 10;
$iNum2 = 0;
# $iNum2 = 1;
function throwError($iNum2) {
  if ($iNum2 == 0){
    throw new RuntimeException("Division by Zero");
  }
  $result = "function end";
  return $result;
}
try{
$response = throwError($iNum2);

$iResult = $iNum1 / $iNum2;
echo ("Division Result of \$iNum1 and $iNum2 = ".($iResult));
}
catch (RuntimeException $e){
echo ("Division by Zero is not possible");
}
echo $response;
echo "after cathc block.";

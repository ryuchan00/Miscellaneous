<?php
// RuntimeExceptionは、catch (Exception $e) でも細く可能
$iNum1 = 10;
$iNum2 = 0;

try{
if ($iNum2 == 0){
throw new RuntimeException("Division by Zero");
}
$iResult = $iNum1 / $iNum2;
echo ("Division Result of \$iNum1 and $iNum2 = ".($iResult)."<br/>");
}
catch (Exception $e){
echo ("Division by Zero is not possible");
}
?>:

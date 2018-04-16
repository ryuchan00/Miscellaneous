<?php
$input_lines = trim(fgets(STDIN));
for ( $i = 0; $i < $input_lines; $i++) {
    $s = trim(fgets(STDIN));
    $s = str_replace(array("\r\n","\r","\n"), '', $s);
    $s = explode(",", $s);
    echo "hello = ".$s[0]." , world = ".$s[1]."\n";
}
?>
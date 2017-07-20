<?

// $handle = fopen("c:\\folder\\resource.txt", "r");

$fp = fopen("data/20170720.txt", "r");
while ($line = fgets($fp)) {
    $inputArray[] = explode(" ", $line);
}

var_dump($inputArray);

fclose($fp);

$old = null;
$max = null;
foreach ($inputArray as $input) {
    switch (true) {
        case (int)$input[1] > $max:
            $result = [];
            $result[] = $input;
            $max = $input[1];
            break;
        case (int)$input[1] == $max:
            $result[] = $input;
            break;
    }
}

var_dump($result);

$fp = fopen("data/answer.txt", "w");

foreach ($result as $v) {
    fwrite($fp, implode(",", $v));
}

fclose($fp);

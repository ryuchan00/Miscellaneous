<?php
// [PHP: 例外(exceptions) - Manual](http://php.net/manual/ja/language.exceptions.php)

class Test {
    public function testing() {
        try {
            try {
                throw new Exception('foo!');
            } catch (Exception $e) {
                // 改めてスロー
                echo "改めてスロー";
                throw new Exception('bar');
            }
        } catch (Exception $e) {
            var_dump($e->getMessage());
        }
    }
}

$foo = new Test;
$foo->testing();

?>

<?php

class Basic
{
    function sayHello()
    {
        echo "Hello!,PHP";
    }

    function sayGoodEvening()
    {
        echo "Good Evening!,PHP";
    }
}

class AdvanceExtends extends Basic
{
    function sayHello()
    {

    }
}

interface Basic
{
    function sayHello();


    function sayGoodEvening();

}

class AdvanceImplements implements Basic
{
    function sayHello()
    {
        echo "Hello!,PHP";
    }

    function sayGoodEvening()
    {
        echo "Good Evening!,PHP";
    }
}

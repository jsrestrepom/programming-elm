module Main exposing (main)

import Html exposing (text)


main =
    text (bottlesOf "juice" 25)


greeting : String
greeting =
    "Hello, Static Elm!"


meaningOfLife : Int
meaningOfLife =
    42


pi : Float
pi =
    3.14


canChuck : Bool
canChuck =
    True


sayHello : String -> String
sayHello name =
    "Hello, " ++ name ++ "."


bottlesOf : String -> (Int -> String)
bottlesOf contents amount =
    String.fromInt amount ++ " bottles of " ++ contents ++ " on the wall."


add : Int -> Int -> String
add x y =
    String.fromInt (x + y)

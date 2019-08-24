module AwesomeDateTest exposing (spec, suite)

import AwesomeDate as Date exposing (Date)
import Expect
import Test exposing (..)


exampleDate : Date
exampleDate =
    Date.create 2012 6 2


leapDate : Date
leapDate =
    Date.create 2012 2 29


suite : Test
suite =
    describe "AwesomeDate"
        [ testDateParts
        , testIsLeapYear
        , testAddYears
        ]


testDateParts : Test
testDateParts =
    describe "date part getters"
        [ test "retrieves the year from a date" <|
            \_ ->
                Date.year exampleDate
                    |> Expect.equal 2012
        , test "retrieves the month from a date" <|
            \_ ->
                Date.month exampleDate
                    |> Expect.equal 6
        , test "retrieves the day from a date" <|
            \_ ->
                Date.day exampleDate
                    |> Expect.equal 2
        ]


testIsLeapYear : Test
testIsLeapYear =
    describe "isLeapYear"
        [ test "returns true if divisible by 4 but not 100" <|
            \_ ->
                Date.isLeapYear 2012
                    |> Expect.true "Expected leap year"
        , test "returns false if not divisible by 4" <|
            \_ ->
                Date.isLeapYear 2010
                    |> Expect.false "Did not expect leap year"
        , test "returns false if divisible by 4 and 100 but not 400" <|
            \_ ->
                Date.isLeapYear 3000
                    |> Expect.false "Did not expect leap year"
        , test "returns true if divisible by 4, 100, and 400" <|
            \_ ->
                Date.isLeapYear 2000
                    |> Expect.true "Expected leap year"
        ]


testAddYears : Test
testAddYears =
    describe "addYears"
        [ test "change a date's year" <|
            \_ ->
                Date.addYears 2 exampleDate
                    |> expectDate 2014 6 2
        , test "prevents leap days on non-leap years" <|
            \_ ->
                Date.addYears 1 leapDate
                    |> expectDate 2013 2 28
        ]


expectDate : Int -> Int -> Int -> Date -> Expect.Expectation
expectDate year month day actualDate =
    let
        expectedDate =
            Date.create year month day
    in
    if actualDate == expectedDate then
        Expect.pass

    else
        Expect.fail <|
            Date.toDateString actualDate
                ++ "\n╷\n| expectDate\n╵\n"
                ++ Date.toDateString expectedDate


spec : Test
spec =
    describe "greaterThan"
        [ test "expects second argument to be greater than first" <|
            \_ -> 42 |> Expect.greaterThan 41
        ]

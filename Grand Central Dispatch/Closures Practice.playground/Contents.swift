//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let f = {(x:Int) -> Int
    in
    return x + 42}

f(9)
f(76)

let closures = [f,
    {(x:Int) -> Int in return x * 2},
    {x in return x - 8},
    {x in x * x},
    {$0 * 42}]

for fn in closures{
    fn(42)
}

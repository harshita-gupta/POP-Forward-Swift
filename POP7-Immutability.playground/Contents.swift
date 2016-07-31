//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Person {
    var name: String
    var age: Int
}

let taylor = Person(name: "taylor", age: 21)

// since it's a let, this is NOT allowed
//taylor.name = "jbiebs"

print(taylor.name)



final class Person2 {
    var name: String
    var age : Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

}

let jbebs = Person2(name: "justin", age: 22)

// because person2 is an object, this IS ALLOWED.
jbebs.name = "selena"

// the implication of the let is this IS NOT ALLOWED:
// jbebs = Person2(name: "selena", age: 22)

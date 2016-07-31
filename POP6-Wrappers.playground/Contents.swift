//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Person {
    var name: String
    var age: Int
    var favoriteIceCream: String
}

let taylor = Person(name: "Taylor", age: 26, favoriteIceCream: "Chocolate")

class PersonBox {
    var person: Person
    
    init(person: Person){
        self.person = person
    }
}

final class TestContainer {
    var box: PersonBox!
}

let container1 = TestContainer()
let container2 = TestContainer()

let taylorinbox = PersonBox(person: taylor)

container1.box = taylorinbox
container2.box = taylorinbox

container1.box.person.favoriteIceCream = "mint"
container1.box.person.favoriteIceCream
container2.box.person.favoriteIceCream

// if you want to box many kinds of things: generics

final class Box<T> {
    var value: T
    
    init(value: T){
        self.value = value
    }
}

let annie = Person(name: "annie", age: 10, favoriteIceCream: "choc")
let annieinbox = Box<Person>(value: annie)


// you are doing loudly what java etc do for you silently  

struct Test {
    var bixx = UIView()
    var biffle = UIView()
}

// what happens when swift tries to copy Test?
// it'll store multiple references 
// two test structs pointing to the same data
// it'll activate ARC
// won't copy them
// it'll retain the UIViews even when specific structs are deallocated
// very inefficient
// just use a class -- it'll do one retain because the entire object gets retained once instead of each individual view

//: Playground - noun: a place where people can play
// this workshop is full of the star wars generation therefore we're doing an example I'm incapable of understanding :)


import UIKit

var str = "Hello, playground"

protocol Targetable {
    // BELOW LINE IS ESSENTIAL: if it doesn't exist, it'll kill dynamic dispatch
    func takeDamage()
}

protocol Fireable {
    func shootAt(target:Targetable)
}

protocol Ejectable {
    func eject()
}

// our instinct is to implement the targetable methods etc in below structs, but no we will not do that. Instead, we will implement in extensions

extension Targetable {
    func takeDamage() {
        print("I'm hit")
    }
}

extension Fireable {
    func shootAt(target: Targetable) {
        print("I'm firing!")
        target.takeDamage()
    }
}

extension Ejectable {
    func eject() {
        print("I ejected!")
    }
}

// now we don't need the implementations here
//struct XWing: Fireable, Targetable, Ejectable {
//    
//}
//
//struct DeathStar: Fireable, Targetable {
//    
//}
//
//struct TIEFighter: Fireable, Targetable, Ejectable {
//    
//}


// since it's repetitive that a lot of the are Targetable, Fireable, Ejectable, we can make a protocol to contain all of it
protocol Fighter: Fireable, Targetable, Ejectable {}

struct XWing: Fighter {
    // now we will override the default implementation with custom implementation
    func eject() {1
        print("Eject? I'd rather crash into the Death Star!")
    }
}

struct DeathStar: Fighter {
    
}

struct TIEFighter: Fighter {
    func eject() {
        print("I'm totes out of here!")
    }
}



let luke = XWing()
let deathStar = DeathStar()

luke.shootAt(deathStar)
deathStar.shootAt(luke)

let fighters : [Fighter] = [XWing(), DeathStar(), TIEFighter(), XWing()]

for fighter in fighters {
    fighter.eject() // polymorphism works
}

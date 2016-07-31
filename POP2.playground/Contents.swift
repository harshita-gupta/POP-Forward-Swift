//: Playground - noun: a place where people can play
// converting our OOP primer project to POP


import UIKit

// when switching to POP, think structs
struct TextEditor {
    var name: String
}
var vim = TextEditor(name: "VIM")

// protocols can't have properties, no states, rather can have requirements
// protocl is a promise
protocol TeamMember {
    // get set is a contract
    var name: String { get set }
    //must have a name and you should be able to get it and set it
    var favoriteTextEditor: TextEditor {get set}
    
    // kills init
    
    // cannot have method bodies for protocol
    func wantsToAttentMeetings() -> Bool
    // instead create an extension to the protocol: providing a default implementation for that method
}

extension TeamMember {
    func wantsToAttentMeetings() -> Bool {
        return true
    }
}

// change these classes to struct
struct ProductOwner: TeamMember { // this will give error of doens't conform to protocol beacuse we don't give it the get set values
    var name: String //putting this here fulfills the contractual requirement
    var favoriteTextEditor: TextEditor
    var stressLevel = 0
}

struct ScrumMaster: TeamMember {
    var name: String //putting this here fulfills the contractual requirement
    var favoriteTextEditor: TextEditor

    var impedimentCount = 0
}


struct Coder: TeamMember {
    var name: String
    var favoriteTextEditor: TextEditor
    private var swiftSkill: Int
    
    mutating func copyCodeFromStackOverflow() -> String {
        swiftSkill -= 1;
        return "The spirit of Stack Overflow is coders helping coders."
    }
    
    // remove override, override has no meaning anymore bc no more inheritance
    func wantsToAttentMeetings() -> Bool {
        return false
    }
    
    func getFormattedSwiftSkill() -> String {
        switch swiftSkill {
        case 0...3:
            return "just learning"
        default:
            return "Chris Lattner is my alter ego"
        }
    }
}


let jessica = Coder(name: "Jessice", favoriteTextEditor: vim, swiftSkill: 8)
let laura = Coder(name: "Laura", favoriteTextEditor: vim, swiftSkill: 5)
let thomas = ProductOwner(name: "Thomas", favoriteTextEditor: vim, stressLevel: 10)

let scrumteam : [TeamMember] = [jessica, laura, thomas]
scrumteam

func introducePerson(person: TeamMember) {
    print("Hello, my name is \(person.name)")
}

scrumteam.forEach { (teamMember) in
    print(introducePerson(teamMember))
}

scrumteam.forEach {
    print(introducePerson($0))
}



// two types of dispatch: call this method
// dynamic dispatch: call this method, but I'm not sure what type of object I am. So at runtime, determines which method to call based on what type I am. It looks in the lookup table of functions to determine the correct thing to call
// DDispatch can be optimized by using "final" for teammember so that it knows that no one is overriding these methods -- swift can therefore optimze and not have to do the full lookup

// When you use final, it compiles the code to kill dynamic dipatch and save that time: less expensive
// With whole module optimization, if you don't subclass, it'll assume final and save time

// has-a versus is-a
// has-a is composition, this is one of the cores of POP

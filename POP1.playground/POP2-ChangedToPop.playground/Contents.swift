//: Playground - noun: a place where people can play
// Primer for OOP, so that we're all on the same page


import UIKit

enum TextEditor {
    case Vim, Emacs, Sublime, Atom
}

class TeamMember {
    var name: String
    var favoriteTextEditor: TextEditor
    
    init(name:String, favoriteText: TextEditor) {
        self.name = name
        self.favoriteTextEditor = favoriteText

    }
    func wantsToAttentMeetings() -> Bool {
        return true
    }

}

class ProductOwner: TeamMember {
    var stressLevel = 0
}

class ScrumMaster: TeamMember {
    var impedimentCount = 0
}


class Coder: TeamMember {
    private var swiftSkill: Int
    
    init(name: String, favoriteText: TextEditor, swiftSkill: Int){
        self.swiftSkill = swiftSkill
        super.init(name: name, favoriteText: favoriteText)
        
    }
    
    func copyCodeFromStackOverflow() -> String {
        swiftSkill -= 1;
        return "The spirit of Stack Overflow is coders helping coders."
    }
    
    override func wantsToAttentMeetings() -> Bool {
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


let jessica = Coder(name: "Jessice", favoriteText: TextEditor.Vim, swiftSkill: 8)
let laura = Coder(name: "Laura", favoriteText: TextEditor.Vim, swiftSkill: 5)
let thomas = ProductOwner(name: "Thomas", favoriteText: TextEditor.Atom)

let scrumteam = [jessica, laura, thomas]
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
//: Playground - noun: a place where people can play

import UIKit
// protocols with associated types are difficult
// a bit like generics: you can work with as-yet-unknown data types
// limits what protocols can do to keep safety

/*
protocol Song {}
struct CountrySong : Song {}

protocol Singer {
    func sing(s: Song)
}

struct CountrySinger: Singer {
    //func sing(s: CountrySong){} doesn't work because A cannot be replaced with B
    // has to be func sing (s: Song){}
}

*/
// we can overcome this issue by making our protocols slightly generic

struct Song {}
struct CountrySong {}

protocol Singer {
    associatedtype SongType // this statement says "our protocol has a hole that needs to be filled by anyone who conforms to it"
    func sing(s: SongType)
//    func singDuetWith(singer: Self)
}

struct CountrySinger : Singer {
    typealias SongType = CountrySong
    func sing(s: SongType) {    }
}

let taylor = CountrySinger()
let garth = CountrySinger()

 // : [Singer] not possible for below declaration, because Swift can't handle storing different singers in same array 
// POP-AssociatedTypes.playground:34:5: error: protocol 'Singer' can only be used as a generic constraint because it has Self or associated type requirements

var singers = [taylor, garth]

let song = Song()


struct OperaSong { }
struct OperaSinger : Singer {
    typealias SongType = OperaSong
    func sing(s: SongType) {}
}

let luciano = OperaSinger()

// can't do this bc they have different associated types
// singers.append(luciano)


// can do this:
struct Band<T: Singer> {
    var singer: T
    var backup: T
}
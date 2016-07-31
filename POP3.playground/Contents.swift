//: Playground - noun: a place where people can play
// Examples


import UIKit

var str = "Hello, playground"

// EXERCISE 1
// modifying Int to add functionality to it
extension Int {
    func squared() -> Int {
        return self * self
    }
}
let i: Int = 5
print(i.squared())


//this won't work, we modified exactly int
//let j: UInt = 5
//print(j.squared())

// instead, we want to modify the protocol that UInt, Int32 ect conform to

extension IntegerType {
    func squared() -> Self { // important to note: we say "Self" instead of "Int" -- will return right type depending on what we're using
        // Self is the class -- "my datatype"
        // self is the instance
        return self * self
    }
}

//now
let j: UInt = 5
print(j.squared())

// EXERCISE 2
// extend integertype to add a clamp mmethod

extension IntegerType {
    func clamp(min: Self, max: Self) -> Self {
        if self < min {
            return min
        }
        if self > max {
            return max
        }
        return self
    }
}

10.clamp(1, max:5)
5.clamp(1, max: 5)
let num = -1
num.clamp(1, max: 5)
100.clamp(0, max:1000)


// EXERCISE 3
// Extend equatable protocol

extension Equatable {
    // will let a
    func matchesArray(items: [Self]) -> Bool{
        for item in items {
            if item != self {
                return false
            }
        }
        return true
    }
}

5.matchesArray([5, 5, 5, 7, 5, 7])

// EXERCISE 4
// create a method that returns if a number is less than all numbers in an array

extension Comparable { // we pick Comparable because it relies on the fact that the types can be compared to each other
    func lessThanArray(items: [Self]) -> Bool {
        for item in items {if item <= self  { return false } }
        return true
    }
}

(-43).lessThanArray([4,-43,7,3,2,6,7,347289])


// EXERCISE 5
// Going to create a method that recreates containers
// we want to create a constrained extension
// only extend collectiontype if it contains equatable things
// eg a custom struct that might not be equatable
// use "where" keyword
// we dig into collection types to find the property that tells us what it holds
// collectiontype's generator's element
// : conforms to
extension CollectionType where Generator.Element: Equatable{
    func myContains(element: Generator.Element) -> Bool {
        
        for item in self { // looping through ourselves, our collection
            if item == element { // checking against our parameter
                return true
            }
        }
        return false
    }
}

[4,-43,7,3,2,6,7,347289].myContains(5)


// EXERCISE 6
// Write a method that extends CollectionType if two Collections contain the same item in any order


extension CollectionType where Generator.Element: Equatable {
    func fuzzyMatch(items: Self) -> Bool{
        if items.count != self.count {return false}
        for (item1, item2) in zip(self, items) {
            if !self.myContains(item2) {
                return false
            }
            if !items.myContains(item1) {
                return false
            }
        }
        return true
    }
}

// alternate extension with tigher constraining that allows for less expensive operation in case of Comparable
extension CollectionType where Generator.Element: Comparable {
    func fuzzyMatch(items:Self) -> Bool {
        let sorted1 = items.sort()
        let sorted2 = self.sort()
        return sorted1 == sorted2
    }
}

[4,-43,7,3,2,6,7,347289].fuzzyMatch([4,-43,7,3,2,6,7,347289])
["a", "b", "a"].fuzzyMatch(["a", "b", "a"])



// EXERCISE 7
extension CollectionType where Generator.Element == String {
    func averageLength() -> Double {
        var sum = 0
        var count = 0
        // can't use inbuilt count property, becuase the
        for string in self {
            count += 1
            sum += string.characters.count
        }
        return Double(sum)/Double(count)
    }
}

[].averageLength()


// EXERCISE 8
// create an extension on collectiontype that affects Int
// how often does the number 5 appear in the list of integers
extension CollectionType where Generator.Element: IntegerType {
    func numberOf5S() -> Int {
        var count = 0
        for item in self {
            var num = item
            while num > 0 {
                if num%10 == 5 {
                    count += 1
                }
                num /= 10
            }
        }
        return count
    }
}
[5,547,6543232,65476,35345575].numberOf5S()
[0, 3].numberOf5S()

// EXERCISE 9
extension Array where Element: Hashable {
    func uniqueValues() -> [Element] {
        var result = [Element]()
        
        for item in self {
            if result.contains(item) {result.append(item) }
        }
            
        return result
        
        // or return Array(Set<self>)
    }
}

// EXERCISE 10
// extend array to have isSorted()
extension Array where Element: Comparable {
    func isSorted() -> Bool { return self.sort() == self }
}

[1,2,4,5,6,7].isSorted()
[1,3,4,6,7,2].isSorted()

["a", "nb", "c"].isSorted()
["a", "b", "c"].isSorted()
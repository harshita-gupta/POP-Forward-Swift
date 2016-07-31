//
//  Animals.swift
//  MillionHairs
//
//  Created by Harshita Gupta on 7/30/16.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import Foundation

enum DogBreeds: String { case Labrador, Malamute, Poodle}

enum CatBreeds: String { case Burmese, Persian, Siamese}

protocol CanDie {
    var name: String {get}
    func die()
}

extension CanDie {
    func die() { print("\(name): I am no more :(")}
}

protocol Noisy { func makeNoise() }
extension Noisy { func makeNoise() { fatalError("This should never be called ")} }

protocol HasVet {
    var name: String {get}
    func assignToVet()
}
extension HasVet {func assignToVet() { print("\(name): I'm assigned to a vet!") } }


protocol Animal: CanDie, Noisy, HasVet {
    var name: String {get set}
}

struct Cat: Animal {
    var name: String
    var breed: CatBreeds
    
    func makeNoise() { print("Meow!", terminator: " ")}
}

struct Dog: Animal {
    var name: String
    var breed: DogBreeds
    
    func makeNoise() { print("Woof!", terminator: " ") }
}

protocol AnimalWrapper: NSCoding{
    associatedtype animalType
    var value: animalType  {get set}
    
    init?(coder aDecoder: NSCoder)
    
    func encodeWithCoder(aCoder: NSCoder)
    
}

class DogWrapper: AnimalWrapper{
    typealias animalType = Dog
    var value: animalType
    init(dog: Dog){
        self.value = dog
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        let dog = Dog(name: aDecoder.decodeObjectForKey("name") as! String, breed: DogBreeds(rawValue: aDecoder.decodeObjectForKey("breed") as! String)!)
        self.value = dog
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        let dog = self.value
        aCoder.encodeObject(self.value.name, forKey: "name")
        aCoder.encodeObject(dog.breed.rawValue, forKey: "breed")
    }
}

class CatWrapper: AnimalWrapper {
    typealias animalType = Cat
    var value: animalType
    init(cat: Cat){
        self.value = cat
    }
    @objc required init?(coder aDecoder: NSCoder) {
        let cat = Cat(name: aDecoder.decodeObjectForKey("name") as! String, breed: CatBreeds(rawValue: aDecoder.decodeObjectForKey("breed") as! String)!)
        self.value = cat
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        let cat = self.value
        aCoder.encodeObject(self.value.name, forKey: "name")
        aCoder.encodeObject(cat.breed.rawValue, forKey: "breed")
        
    }
}

//extension Array where Element: Animal {
//    func wrappedArray() -> [AnimalWrapper] {
//        var wrappedArray = [AnimalWrapper]()
//        for item in self {
//            if let item = obj as? Dog {
//                wrappedArray.append(DogWrapper(dog: currAnimal as Dog)
//            }
//            
//        }
//    }
//}




/*
 
 //
 //  Animals.swift
 //  MillionHairs
 //
 //  Created by Harshita Gupta on 7/30/16.
 //  Copyright © 2016 Paul Hudson. All rights reserved.
 //
 
 import Foundation
 
 enum DogBreeds: String { case Labrador, Malamute, Poodle}
 
 enum CatBreeds: String { case Burmese, Persian, Siamese}
 
 protocol CanDie {
 var name: String {get}
 func die()
 }
 
 extension CanDie {
 func die() { print("\(name): I am no more :(")}
 }
 
 protocol Noisy { func makeNoise() }
 extension Noisy { func makeNoise() { fatalError("This should never be called ")} }
 
 protocol HasVet {
 var name: String {get}
 func assignToVet()
 }
 extension HasVet {func assignToVet() { print("\(name): I'm assigned to a vet!") } }
 
 
 protocol Animal: CanDie, Noisy, HasVet {}
 
 struct Cat: Animal {
 var name: String
 var breed: CatBreeds
 
 func makeNoise() { print("Meow!", terminator: " ")}
 }
 
 struct Dog: Animal {
 var name: String
 var breed: DogBreeds
 
 func makeNoise() { print("Woof!", terminator: " ") }
 }
 
 class DogWrapper: NSCoding{
 var value: Dog
 init(dog: Dog){
 self.value = dog
 }
 
 @objc required init?(coder aDecoder: NSCoder) {
 self.value.name = aDecoder.decodeObjectForKey("name") as! String
 let breed = aDecoder.decodeObjectForKey("breed") as! String
 self.value.breed = DogBreeds(rawValue: breed)!
 }
 
 @objc func encodeWithCoder(aCoder: NSCoder) {
 aCoder.encodeObject(self.value.breed.rawValue, forKey: "breed")
 aCoder.encodeObject(self.value.name, forKey: "name")
 }
 }
 
 class CatWrapper: NSCoding {
 var value: Cat
 init(cat: Cat){
 self.value = cat
 }
 @objc required init?(coder aDecoder: NSCoder) {
 self.value = Cat(name: aDecoder.decodeObjectForKey("name") as! String, breed: CatBreeds(rawValue: aDecoder.decodeObjectForKey("breed") as! String)!)
 }
 
 @objc func encodeWithCoder(aCoder: NSCoder) {
 aCoder.encodeObject(self.value.breed.rawValue, forKey: "breed")
 aCoder.encodeObject(self.value.name, forKey: "name")
 }
 }
 
 extension Array where Element: Animal {
 func wrappedArray() -> [AnimalWrapper] {
 var wrappedArray = [AnimalWrapper]()
 for item in self {
 wrappedArray.append(AnimalWrapper(name: <#T##String#>)
 }
 }
 }
 
 */


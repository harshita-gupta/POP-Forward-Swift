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

class AnimalWrapper: NSCoding{
    var name: String
    init(name: String){
        self.name = name
    }
    @objc required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as! String
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
    }

}

class DogWrapper: AnimalWrapper{
    var breed: DogBreeds
    init(dog: Dog){
        self.breed = dog.breed
        super.init(name: dog.name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        let breed = aDecoder.decodeObjectForKey("breed") as! String
        self.breed = DogBreeds(rawValue: breed)!
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(breed.rawValue, forKey: "breed")
        super.encodeWithCoder(aCoder)
    }
}

class CatWrapper: AnimalWrapper {
    var breed: CatBreeds
    init(cat: Cat){
        self.breed = cat.breed
        super.init(name: cat.name)
    }
    required init?(coder aDecoder: NSCoder) {
        let breed = aDecoder.decodeObjectForKey("breed") as! String
        self.breed = CatBreeds(rawValue: breed)!
        super.init(coder: aDecoder)
    }
    
    override func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(breed.rawValue, forKey: "breed")
        super.encodeWithCoder(aCoder)
    }
}

extension Array where Element: Animal {
    func wrappedArray() -> [AnimalWrapper] {
        
    }
}

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
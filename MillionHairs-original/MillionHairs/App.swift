//
//  App.swift
//  MillionHairs
//
//  Totally Not Created by TwoStraws on 01/07/2016.
//  Copyright © 2016 Haul Pudson. All rights reserved.
//

import Cocoa

enum Screens {
	case MainMenu, Create, Select, Edit
}

class App: NSObject {
	var screen = Screens.MainMenu
	var animals = [Animal]()
	var selectedAnimal: Animal?

	func run() {
		load()

		while (true) {
			printMenu()

			if let userInput = readLine() {
				processUserInput(userInput)
			} else {

			}
		}
	}

	func printMenu() {
		switch screen {
		case .MainMenu:
			print("Welcome to Million Hairs!")
			print("Please choose an option:")
			print("\t1. Check in a new animal")
			print("\t2. Edit an existing animal")

		case .Select:
			// The boss's husband said we should make the app fun to use, so 
			// I made it bark and meow – happy now? At least I got the chance
			// to show I'm a functional programming guru…
			animals.forEach {
				$0.makeNoise()
			}

			print("")

			print("Please select an animal, or hit return to")
			print("go back to the main menu.")

			for (index, animal) in animals.enumerate() {
				// FIXME: The boss doesn't like this counting from 0
				print("\(index). \(animal.name)")
			}

		case .Create:
			print("Enter their name, type, and breed separated by a comma,")
			print("or hit return to go back to the main menu.")
			break

		case .Edit:
			print("Select an option, or hit return to go back to the main menu.")
			print("1. Assign vet to animal.")
			print("2. Mark \(selectedAnimal!.name) as dead.")
			print("3. Delete animal from records")
		}
	}

	func processUserInput(userInput: String) {
		let command = userInput.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())

		switch screen {
		case .MainMenu:
			switch command {
			case "1":
				screen = .Create
			case "2":
				screen = .Select
			default:
				// unknown command – do nothing
				break
			}
		case .Create:
			if command.characters.count == 0 {
				screen = .MainMenu
			} else {
				let split = command.componentsSeparatedByString(",")
				guard split.count == 3 else { return }

				let name = split[0]
				let type = split[1].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).lowercaseString
				let breed = split[2].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).capitalizedString

				var animal: Animal?

				if type == "dog" {
					if let breedValue = DogBreeds(rawValue: breed) {
						animal = Dog(name: name, breed: breedValue)
					}
				} else if type == "cat" {
					if let breedValue = CatBreeds(rawValue: breed) {
						animal = Cat(name: name, breed: breedValue)
					}
				}

				guard animal != nil else { return }
				animals.append(animal!)
				save()

				// FIXME: Shouldn't we show some sort of message here?

				screen = .MainMenu
			}
		case .Select:
			if command.characters.count == 0 {
				screen = .MainMenu
			} else {
				// FIXME: What if the user types an invalid number?
				selectedAnimal = animals[Int(command)!]
				screen = .Edit
			}
		case .Edit:
			if command.characters.count == 0 {
				screen = .Select
			}

			switch command {
			case "1":
				selectedAnimal!.assignToVet()

			case "2":
				selectedAnimal!.die()

			case "3":
				// FIXME: What's the difference between ? and !?
				animals.removeAtIndex(animals.indexOf(selectedAnimal!)!)
				screen = .Select

			default:
				// unknown command – do nothing
				break
			}
		}
	}

	func load() {
		let path = Helper.getPathInDocumentsDirectory("animals")
		if let data = NSData(contentsOfURL: path) {
			if let array = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Animal] {
				animals = array
			}
		}
	}

	func save() {
		let path = Helper.getPathInDocumentsDirectory("animals")
		let data = NSKeyedArchiver.archivedDataWithRootObject(animals)
		data.writeToURL(path, atomically: true)
	}
}


class Animal: NSObject, NSCoding {
	var name: String

	init(name: String) {
		self.name = name
	}

	required init?(coder aDecoder: NSCoder) {
		self.name = aDecoder.decodeObjectForKey("name") as! String
	}

	func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(name, forKey: "name")
	}

	func assignToVet() {
		print("\(name): I'm assigned to a vet!")
	}

	func die() {
		print("\(name): I am no more :(")
	}

	func makeNoise() {
		fatalError("This should never be called ")
	}
}

enum CatBreeds: String {
	case Burmese, Persian, Siamese
}

class Cat: Animal {
	var breed: CatBreeds

	init(name: String, breed: CatBreeds) {
		self.breed = breed
		super.init(name: name)
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

	override func makeNoise() {
		print("Meow!", terminator: " ")
	}
}

enum DogBreeds: String {
	case Labrador, Malamute, Poodle
}

class Dog: Animal {
	var breed: DogBreeds

	init(name: String, breed: DogBreeds) {
		self.breed = breed
		super.init(name: name)
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

	override func makeNoise() {
		print("Woof!", terminator: " ")
	}
}



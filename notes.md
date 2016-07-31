Paul Hudson
@twostraws

POP and OOP solve similar problems
OOP is still central to iOS dev because of the frameworks that we use
We are going to use both side-by-side

OOP terms central to POP discussion
Abstraction
Encapsulation
Inheritance
Polymorphism
final cannot be overridden
dynamic dispatch — determining what kind of class it is and therefore what methods to call

POP:
Abstraction
Encapsulation
Composition becomes preferable to inheritance
Polymorphism

fighting muscle memory so that you think POP first, and not just OOP

what does pop change?
bring functionality together from smaller parts rather than inheriting it from superclasses
this allows you to retroactively model your architecture
instead of drawing out your class hierarchies on whiteboards, with POP you complete flatten and can change your mind later a lot
rough idea and then changing your mind a lot
less all up-front
Downsides:
No stored properties

eliminating state: no stored properties and inheriting them
you are no longer inheriting things from guys above it
inheritance still exists though

define small, independent protocols that we combine together — more modular
     discrete pieces of functionality are easier to take out and replace

protocols contain methods and computed properties, but no states

you can apply protocols to specific things “extend UI view when this is the case"

I’ve got a horse and I have a bird and I want a pegasus
multiple inheritances is hard
if you inherit from three classes, in what order are constructors called?
no constructors in pop
which methods get called?

with POP, E can decide what parts of A, B, C, D it wants:
     in inheritance, ABCD tell E what it’ll get
     in POP, E decides what it gets, child makes its mind up
     much more flexible

When you call a method, Swift will choose the method that is most unique and best constrained and pick that one

build lots of small, independent pieces of functionality to piece together later on
build big things by combining lots of smaller things: it’s like functional programming: FP and POP work well together

In obj-c, everything was a class
swift, everything is a value type language, everything is a Struct

How is POP implemented?
     Protocols are old school
     extensions are also old
     both have a serious limitations
     protocols don’t allow you to define functionalities, implement stuff
     extensions apply to _Everything_ of that class, it’s kinda crazy
     Swift 2.0 brought them together in protocol extensions
     because of protocol extensions, we get to rewrite functions for datatypes

OOP primer:
     // two types of dispatch: call this method
// dynamic dispatch: call this method, but I'm not sure what type of object I am. So at runtime, determines which method to call based on what type I am. It looks in the lookup table of functions to determine the correct thing to call

converting POP to OOP:
create a protocol
create extension separately
can’t create stored properties, but can require them
mark mutating methods
use method-wise init
structs instead of classes

why do we switch from classes to structs?
     value types versus reference types

obj-c is aggressively reference types, swift is aggressively value types
only reference types in swift are classes and closures

value types give isolation:
     each piece of data has exactly one owner
     no one else can change it
     immediate thread safety, no race conditions can exist with value types
     no need for defensive copying
     easier to write tests for
     easier to debug

reference types:
     still have an important part to play
     we have object-based frameworks

when do you pick a class, and when do you pick a struct?
make your intension clear

POP allows your code to be flatter, less hierarchies

Protocols we’ll be using in this session:
Equatable,
Comparable (implies equatable)
Hashable
CollectionType
IntegerType: can it have an integer

Quirks:
     Protocol extensions can’t be used in or seen in Objective-C
     Always done in two stages:
          protocol
          extension
     don’t list a method only once or the behavior changes

Associated Types make things weird:
POP-AssociatedTypes.playground:34:5: error: protocol 'Singer' can only be used as a generic constraint because it has Self or associated type requirements
Swift cannot handle code that can’t be fully type-checked at compile time

OOP vs. POP
- All of model can and should use POP —> do this now Harshita
- Try to think of this as your value layer: inert, isolated data that gets manipulated elsewhere
- When you hit bridging problems, create converter objects

Tricky choices:
- Views: no functionality difference between using POP and regular extensions
- Semantic difference: POP makes you declare additions rather than applying them everywhere
- makes your intent clearer

taxing choices:
- obj-c needs a struct, but you have a struct
- example: NSCoding
- “don’t try to fight the system” - apple quote lmao
- don’t be ashamed to go back to classes where it’s the best fit
- consider creating wrappers instead
- classes can use pop too: some inheritance, but can do more modular component-based pop as well

Migrating OOP to POP
project!
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble : Double = 70

print(implicitInteger)
print(explicitDouble)

let label = "The width is "
let width = 94
// let withLabel = label + width  // error  String + Int
let withLabel = label + String(width)


print(withLabel)

// Use \() to include a floating-point calculation in a string and to include someone’s name in a greeting.
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit"
print(appleSummary, fruitSummary)

// create arrays and dictionaries using brackets[]
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

var occupations = [
	"Malcolm" : "Captain",
	"Kaylee" : "Mechanic",
]

occupations["Jayne"] = "Public Relations"

print(occupations)

let emptyArray = [String]()
let emptyDictionary = [String: Float]()

print(emptyArray, emptyDictionary)

// Control Flow
let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
	if score > 50 {
		teamScore += 3
	} else {
		teamScore += 1
	}
	
}
print (teamScore)

var optionalString : String? = "Hello"
print(optionalString == nil)

var optionalName: String? = "John Appleseed"
var greeting = "Hello"
if let name = optionalName {
	greeting = "Hello, \(name)"
}
print(greeting)

let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"
print(informalGreeting)

// Switches
let vegetable = "red pepper"
switch vegetable {
	case "celery":
		print("Add some raisins and make ant on a log.")
	case "cucumeber", "watercress":
		print("That would make a good tea sandwich.")
	case let x where x.hasSuffix("pepper"):
		print("Is it a spicy \(x)?")
	default:
		print("Everything tastes good in soup.")
}

// use for -in to iterate over iteams in dictionary by providing a pari of names to use for each key-value pair.
// Dictionaries are an unordered collection, so their keys and values are iterated in an arbitray order.

let interestingNumbers = [
	"Prime": [2, 3, 5, 7, 11, 13],
	"Fibonacci": [1, 1, 2, 3, 5, 8],
	"Square": [1, 4, 9, 16, 25],
]
var largest = 0
var maxVal = 0
for (kind, numbers) in interestingNumbers {
	for number in numbers {
		if number > largest {
			largest = number
			maxVal = max(largest, maxVal)
			print("current max val is", maxVal)
		}
	}
}
print(largest)
// Add another variable to keep track of which kind of number was the largest, as well as what that largest number was.

// Use While to repeat a block of code until a condition changes.
var n = 2;
while (n < 100) {
	n = n * 2
}
print(n)

var m = 2
repeat {
	m = m * 2
} while m < 100
print(m)

// keep an index in a loop by using ..< to make a range of indexes
var total = 0
for i in 0..<4 {
	total += i
}
print(total)
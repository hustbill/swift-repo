let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble : Double = 70

print(implicitInteger)
print(explicitDouble)

let label = "The width is "
let width = 94
let withLabel = label + String(width)

print(withLabel)

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
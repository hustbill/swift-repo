import Foundation 
let city = "Boston"

let trainName = "the Red Line"

var subwayStops = [
// Stop name and busyness on a scale of 1- 10
    ("Harvard Square", 6),
    ("Kendall / MIT", 5),
    ("Central Square", 7),
    ("Charles MGH", 4),
    ("Park Stree", 10)
    ]
    
    var passengers = 0
    
    for i in 0..<subwayStops.count {
        var (stopName, busyness) = subwayStops[i] 
        // New passengers boarding the train
        var board:Int
        
        switch (busyness) {
        case 1...4: board = 15
        case 5...7: board = 30
        case 7..<9: board = 45
        case 10: board = 50
        default: board = 0
        }
    // Some passengers mayleave the train at each stop
    let randomNumber = Int(arc4random_uniform(UInt32(passengers)))
    
    // Ensure that passengers never becomes negative
    if randomNumber < passengers {
        passengers -= randomNumber
        print("\(randomNumber) leave the train")
    }
    
    passengers += board
    print("\(board) new passengers board at \(stopName)")
    print("\(passengers) current on board")
 }
 print("A total of \(passengers) passengers were left on \(trainName) in \(city)")
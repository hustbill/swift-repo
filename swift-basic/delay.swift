import Foundation

// let seconds = 4.0
// let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
// let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//
// var i = 0
// print("start")
//
//
// func myPerformeCode(timer : NSTimer) {
//
//    print("myPerformeCode")
// }
//
// let myTimer : NSTimer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: Selector("myPerformeCode:"), userInfo: nil, repeats: false)
//
//

var s = ""
let array = [8, 2, 53, 46, 55, 53, 55, 51]

func convert2dec(array : [Int]) -> String {
      var s = ""
      let len = array.count - 1
      
      for index in 0...len{
          s += String(UnicodeScalar(array[index]))
      }
      
      return s
  }
  
  print(convert2dec(array))

// for index in 0...7{
// 	s += String(UnicodeScalar(array[index]))
// }
//
// print(s)
//
//
// let value = 97
// // Convert Int to a UnicodeScalar.
// let u = UnicodeScalar(value)
// // Convert UnicodeScalar to a Character.
// let char = Character(u)
//
// // Write results.
// print(char)
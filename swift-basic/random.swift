import Foundation

let randomNumber = arc4random_uniform(10)
print(randomNumber)

enum CompassPoint : UInt8 {
    case North = 0xC0
    case South = 0xC1
    case East = 0xC2
    case West = 0xC3
}

var directionToHead = CompassPoint.West
print(directionToHead.rawValue)


var optcodeDic : Dictionary<String, UInt8> = [
     "CAL1"  : 0xC0,
       "CAL2"  : 0xC1,
       "CAL3"  : 0xC2,
       "CAL4"  : 0xC3,
       "CAL5"  : 0xC4,
       "CAL6"  : 0xC5,
       "CAL7"  : 0xC6,
       "CAL8"  : 0xC7,
       "CAL9"  : 0xC8,
       "CAL10"  : 0xC9,
       "CAL11"  : 0xCA,
       "CAL12"  : 0xCB,
       "CAL13"  : 0xCC,
       "CAL14"  : 0xCD,
       "CAL15"  : 0xCF,
       "CAL16"  : 0xD0,
       "CAL17"  : 0xD1,
       "CAL18"  : 0xD2
   ]

   let stepNum = "CAL15"

   var mycode = optcodeDic[stepNum]!
   print(mycode)
   

enum Optcode : UInt8 {
    case  CAL1 = 0xC0
    case  CAL2 = 0xC1
    case  CAL3 = 0xC2
    case  CAL4 = 0xC3
    case  CAL5 = 0xC4
    case  CAL6 = 0xC5
    case  CAL7 = 0xC6
    case  CAL8 = 0xC7
    case  CAL9 = 0xC8
    case  CAL10 = 0xC9
    case  CAL11 = 0xCA
    case  CAL12 = 0xCB
    case  CAL13 = 0xCC
    case  CAL14 = 0xCD
    case  CAL15 = 0xCF
    case  CAL16 = 0xD0
    case  CAL17 = 0xD1
    case  CAL18 = 0xD2
}







func getOptCode(stepNum : String) {
	
	print("getOptCode")
 }
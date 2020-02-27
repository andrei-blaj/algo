import Foundation

let strValue = "1337"

// convert this strValue to a number

// option 1
func convert(value: String) -> Int {
    return Int(value) ?? 0
}

convert(value: strValue)

// option 2

let hashMap = [
    "0" as Character: 0,
    "1": 1,
    "2": 2,
    "3": 3,
    "4": 4,
    "5": 5,
    "6": 6,
    "7": 7,
    "8": 8,
    "9": 9
]

func convert(_ value: String) -> Int {
    
    var total = 0
    
    for (i, char) in value.enumerated() {
        let exponent = value.count - i - 1
        if let digit = hashMap[char] {
            let num = Decimal(digit) * pow(10, exponent)
            total += NSDecimalNumber(decimal: num).intValue
        }
    }
    
    return total
}

print(convert(strValue))

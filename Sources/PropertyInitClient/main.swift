// Testfile for PropertyInit

import PropertyInit
import SwiftUI



let a = 17
let b = 25

@propertyInit
struct MyStruct {

    var a: Int
    var b: String
    let c: any View
    var huhu: Int {
        get {
            1
        }
        set {
            a  = newValue
        }
    }
    var d: Color
    
}



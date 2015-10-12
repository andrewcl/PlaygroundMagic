//: Playground - noun: a place where people can play

import UIKit

//NOTE: Protocol extension to make handling Swift strong typing easier.
//    Uses protocol extension to Numeric type to bypass need for casting.
//    Based off Realm.io presentation by Richard Fox @ Propeller Labs
//Source: http://foxinswift.com/2015/08/17/cast-free-arithmetic/
//Source: https://github.com/Nadohs/Cast-Free-Arithmetic-in-Swift

extension CGFloat{
    init(_ value: CGFloat){
        self.init(Double(value))
    }
}

protocol NumberConvertible{
    init(_ value: Int)
    init(_ value: Float)
    init(_ value: Double)
    init(_ value: CGFloat)
}

extension CGFloat : NumberConvertible {}
extension Double  : NumberConvertible {}
extension Float   : NumberConvertible {}
extension Int     : NumberConvertible {}


extension NumberConvertible {
    
    func convert<T: NumberConvertible>() -> T {
        switch self {
        case let x as CGFloat:
            return T(x)
        case let x as Float:
            return T(x)
        case let x as Int:
            return T(x)
        case let x as Double:
            return T(x)
        default:
            fatalError("NumberConvertible convert failed!")
            return T(0)
        }
    }
}

//PART: 2
//MARK: NumberConvertible custom operators
typealias PreferredType = Double

func + <T:NumberConvertible, U:NumberConvertible>(lhs: T, rhs: U) -> PreferredType {
    let v: PreferredType = lhs.convert()
    let w: PreferredType = rhs.convert()
    return v+w
}

//PART: 3

infix operator ?= { associativity right precedence  90 assignment}

func ?= <T:NumberConvertible, U:NumberConvertible>(inout lhs: T, rhs: U){
    lhs = rhs.convert()
}


infix operator ^^ { precedence  100 }

func ^^ <T:NumberConvertible, U:NumberConvertible>(var lhs: T, rhs: U) -> T{
    
    lhs = rhs.convert()
    let x:T = rhs.convert()
    return x;
}
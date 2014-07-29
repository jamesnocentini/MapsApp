// Playground - noun: a place where people can play
import UIKit

var d = 10.9

d

var i = (d as NSNumber).integerValue

var tuple: (Int, String)
tuple = (200, "hello")

//Handy for each row in the csv
let row = (20.0, 10.0, 30000)
let (lat, _, alt) = row
lat
alt
row.2
var row2 = (lat: 20.0, lon: 10.0, alt: 30000)
row2.lat
//there is a typealias for the empty tuple type called Void
var empty: Void
empty = ()
//There is no 1-tuple in Swift, only the value itself,
//There is no 1-tuple type in Swift, only the type itself
//Use for tuples: multiple assignments, to return multiple values from a function

var arr = [1,2,3]
for tuple in enumerate(arr) {
    tuple.element
}

//: Playground - noun: a place where people can play

import UIKit

var word = "coffee"

var letterArray = word.characters
var guessedArray = [String]()

for letter in letterArray {
    guessedArray.append("_ ")
}

print(guessedArray.joined())

var letterGuessed = "f"

for (index, letter) in word.characters.enumerated() {
    if Character(letterGuessed) == letter {
        guessedArray[index] = letterGuessed + " "
    }
}

print(guessedArray.joined())

var array = ["a", "b", "c", "d", "e"]

print(array.contains("e"))
print(array.contains("f"))
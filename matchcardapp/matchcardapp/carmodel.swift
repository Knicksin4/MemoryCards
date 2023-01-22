//
//  carmodel.swift
//  matchcardapp
//
//  Created by Tavia Garvey on 6/16/20.
//  Copyright © 2020 Ryan Garvey. All rights reserved.
//

import Foundation

class cardmodel {
    
    func getcards() -> [Card] {
        
        //declare an empty array
        var generatedcards = [Card]()
        //randomly generate 8 pairs of cards
        for _ in 1...8 {
            //generate random number
            let randomnumber = Int.random(in:1...13)
            //create 2 new card objects
            //make sure pairs are not repeated
            
            let cardOne = Card()
            let cardTwo = Card()
            //set image names
            cardOne.imagename = "card\(randomnumber)"
            cardTwo.imagename = "card\(randomnumber)"
            //add to array
            generatedcards += [cardOne, cardTwo]
            
            print(randomnumber)
        }
        //randomize cards within array
        generatedcards.shuffle()
        // return the array
        return generatedcards
        
    }
}

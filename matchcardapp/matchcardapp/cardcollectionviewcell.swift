//
//  cardcollectionviewcell.swift
//  matchcardapp
//
//  Created by Tavia Garvey on 6/16/20.
//  Copyright © 2020 Ryan Garvey. All rights reserved.
//

import UIKit

class cardcollectionviewcell: UICollectionViewCell {
    
    
    @IBOutlet weak var frontimageview: UIImageView!
    
    @IBOutlet weak var backimageview: UIImageView!
    
    var card:Card?
    
    func configurecell(card:Card) {
        //keep track of the card this cell represents
        
        self.card = card
        // set the front image view to the image that represents the card
        
        frontimageview.image = UIImage(named: card.imagename)
        
        // reset the state of the cell by checking the flip status of the ard then sowing the front or back image view accordingly
        if card.ismatached == true {
            backimageview.alpha = 0
            frontimageview.alpha = 0
            return
        }
        else {
            backimageview.alpha = 1
            frontimageview.alpha = 1
        }
       if  card.isflipped == true {
            // show the front image view
            flipUp(speed: 0)
            
        }
        else {
        
        flipDown(speed: 0, delay: 0)
            
            // show the back image view
        }
        
    }
    
    func flipUp(speed:TimeInterval = 0.3 ){
        UIView.transition(from: backimageview, to: frontimageview, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        
        card?.isflipped = true
        
    }
    
    func flipDown (speed: TimeInterval = 0.3, delay:TimeInterval = 0.5) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            UIView.transition(from: self.frontimageview, to: self.backimageview, duration: speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        
        
       
        }
        card?.isflipped = false
    }
    func remove() {
        backimageview.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontimageview.alpha = 0
        }, completion: nil)
    }
    
}

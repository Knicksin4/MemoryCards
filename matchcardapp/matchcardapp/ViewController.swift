//
//  ViewController.swift
//  matchcardapp
//
//  Created by Tavia Garvey on 6/16/20.
//  Copyright © 2020 Ryan Garvey. All rights reserved.
//

import UIKit

class ViewController: UIViewController  , UICollectionViewDataSource , UICollectionViewDelegate{
    
    
    
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    let model = cardmodel()

    var cardsarray = [Card]()
    
    var timer:Timer?
    var mililiseconds:Int = 10 * 1000
    
    var firstflippedcardindex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardsarray = model.getcards()
        
        // set the view controller as the datasource and delegate of the collectionview
        collectionview.dataSource = self
        collectionview.delegate = self
        
        //initialize the timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    //Mark: timer methods
    
   @objc func timerFired() {
        // decrement the counter u
    mililiseconds -= 1
    //pdate the label
    let seconds:Double = Double(mililiseconds)/1000.0
     timeLabel.text = String(format: "Time remaining: %.2f", seconds)
    //stop counter if it reaches 0
    if mililiseconds == 0 {
        timeLabel.textColor = UIColor.red
        timer?.invalidate()
        
         checkForGameEnd()
    }
     // TODO: check if user cleared all pairs
   
    }
    
    // MARK: -  collection view delegate methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsarray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       //get a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardcell", for: indexPath) as! cardcollectionviewcell
        

        //return cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // configure the state of the cell based on the properties of the card that it represents
        let Cardcell = cell as? cardcollectionviewcell
        
        let card = cardsarray[indexPath.row]
        
        //TODO: configure it
        Cardcell?.configurecell(card: card)
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // get a refernce to the tapped cell
       let cell = collectionView.cellForItem(at: indexPath) as? cardcollectionviewcell
        
        if cell?.card?.isflipped == false && cell?.card?.ismatached == false {
        
        cell?.flipUp()
            // check if this is the first card that was flipped or the second card
            
            if firstflippedcardindex == nil {
                
                firstflippedcardindex = indexPath
                
            }
            
            else{
                
                checkformatch(indexPath)
                
            }
    }
    
        

}
    //MARK: - Game logi methods
    func checkformatch(_ secondflippedcardindex: IndexPath){
        //get two card objects for the indices and see if they match
        let cardone = cardsarray[firstflippedcardindex!.row]
        let cardtwo = cardsarray[secondflippedcardindex.row]
        
        let cardonecell = collectionview.cellForItem(at: firstflippedcardindex!) as? cardcollectionviewcell
        let cardtwocell = collectionview.cellForItem(at: secondflippedcardindex) as? cardcollectionviewcell
        
        if cardone.imagename == cardtwo.imagename {
            // is a match
            cardone.ismatached = true
            cardtwo.ismatached = true
            
            cardonecell?.remove()
            cardtwocell?.remove()
            
            checkForGameEnd()
            
        }
        
        else {
            cardone.isflipped = false
            cardtwo.isflipped = false
            
            cardonecell?.flipDown()
            cardtwocell?.flipDown()
        }
        
        firstflippedcardindex = nil
    }
    
    func checkForGameEnd() {
        //check if theres any card that is unmatched
        
        var hasWon = true
        
        for card in cardsarray {
            if card.ismatached == false {
                hasWon = false
                break
                
            }
        }
        
        if hasWon  {
            
            showAlert(title: "Congratulations!!", message: "You have matched all cards")
            
    }
        
        else {
            if mililiseconds <= 0 {
                showAlert(title: "Times up !", message: "Better luck next time")
            }
            
        }
}
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}

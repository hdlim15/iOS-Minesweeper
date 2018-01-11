//
//  ViewController.swift
//  Minesweeper
//
//  Created by Hyuckin Lim on 11/30/15.
//  Copyright © 2015 Hyuckin Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenWidth = Int(self.view.frame.size.width)
        let screenHeight = Int(self.view.frame.size.height)
        
        
        var buttonArray = [UIButton]()
        
        for i in 0...63 //creates the 8x8 board
        {
            let myButton = UIButton()
            myButton.frame = CGRectMake(CGFloat(40*(i%8)+(screenWidth/2-160)), CGFloat(40*(i/8)+screenHeight/2-160), 40, 40)
            myButton.layer.borderWidth = 2.0
            myButton.layer.borderColor = (UIColor.blackColor() ).CGColor
            myButton.addTarget(self, action: "pressedAction:", forControlEvents: .TouchUpInside)
            myButton.backgroundColor = UIColor.blueColor()
            myButton.setTitle("0", forState: .Normal)
            myButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
            myButton.tag = 0
            self.view.addSubview(myButton)
            
            buttonArray.append(myButton)
        }
        
        for _ in 0...9 //assigns ten random bombs to the board
        {
            let bomb = Int(arc4random_uniform(63))
            buttonArray[bomb].tag = 1
        }
        
        buttonArray[0].setTitle(String(isBomb(buttonArray[1])+isBomb(buttonArray[8])+isBomb(buttonArray[9])), forState: .Normal)
        buttonArray[7].setTitle(String(isBomb(buttonArray[6])+isBomb(buttonArray[14])+isBomb(buttonArray[15])), forState: .Normal)
        buttonArray[56].setTitle(String(isBomb(buttonArray[48])+isBomb(buttonArray[49])+isBomb(buttonArray[57])), forState: .Normal)
        buttonArray[63].setTitle(String(isBomb(buttonArray[54])+isBomb(buttonArray[55])+isBomb(buttonArray[62])), forState: .Normal)
        
        topRow(buttonArray)
        bottomRow(buttonArray)
        leftRow(buttonArray)
        rightRow(buttonArray)
        centers(buttonArray)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pressedAction(sender: UIButton!) {  //if a button is pressed
       // var count = 0
        
        if sender.tag != 1   //if the button is not a mine, show the number
        {
            sender.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            sender.enabled = false
            count++
            if (count == 54) //all bombs chosen
            {
                performSegueWithIdentifier("victory", sender: self)
            }
            
            
        }
        else  //if the button is a bomb
        {
            sender.backgroundColor = UIColor.grayColor()
            performSegueWithIdentifier("mySegue", sender: self) //sends user to losing screen
        }
        
    }
    
    func isBomb(button: UIButton) -> Int {  //checks if a button is a bomb
        var x = 0
        if (button.tag == 1) {
            x++
        }
        return x
        
    }
    
    //the following five functions change each button's title to the number of neighboring bombs
    func topRow(myArray: [UIButton]) {
        for i in 1...6
        {
            myArray[i].setTitle(String(isBomb(myArray[i-1])+isBomb(myArray[i+1])+isBomb(myArray[i+7])+isBomb(myArray[i+8])+isBomb(myArray[i+9])), forState: .Normal)
        }
    }
    
    func bottomRow(myArray: [UIButton]) {
        for i in 57...62
        {
            myArray[i].setTitle(String(isBomb(myArray[i-9])+isBomb(myArray[i-8])+isBomb(myArray[i-7])+isBomb(myArray[i-1])+isBomb(myArray[i+1])), forState: .Normal)
        }
    }
    
    func leftRow(myArray: [UIButton]) {
        for var i = 8; i < 49; i+=8
        {
            myArray[i].setTitle(String(isBomb(myArray[i-8])+isBomb(myArray[i-7])+isBomb(myArray[i+1])+isBomb(myArray[i+8])+isBomb(myArray[i+9])), forState: .Normal)
        }
    }
    
    func rightRow(myArray: [UIButton]) {
        for var i = 15; i < 56; i+=8
        {
            myArray[i].setTitle(String(isBomb(myArray[i-9])+isBomb(myArray[i-8])+isBomb(myArray[i-1])+isBomb(myArray[i+7])+isBomb(myArray[i+8])), forState: .Normal)
        }
    }
    
    func centers(myArray: [UIButton]) {
        for var i = 9; i < 50; i+=8
        {
            for j in 0...5
            {
                let k = i+j
                myArray[k].setTitle(String(isBomb(myArray[k-9])+isBomb(myArray[k-8])+isBomb(myArray[k-7])+isBomb(myArray[k-1])+isBomb(myArray[k+1])+isBomb(myArray[k+7])+isBomb(myArray[k+8])+isBomb(myArray[k+9])), forState: .Normal)
            }
        }
    }

}


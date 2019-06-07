//
//  ImageViewController.swift
//  L2_toroyanseda
//
//  Created by Seda on 08/04/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireImage



class ImageViewController: UIViewController {
    var counting:Int = 250
    let checkedImage = UIImage(named: "heart_2")
   var unCheckedImage = UIImage(named: "heart_1")
    var index:Int = 0
   var isChecked:Bool = false
    var image = UIImage()
    var imgMa = [UIImage]()
    var likesTitle = [Int]()
    var likesState = [Int]()
    var indexSelected = Int()
    var i = 0
    var repostsCount = [Int]()
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
   
    @IBOutlet weak var repostLabel: UILabel!
    
    override func viewDidLoad() {
       super.viewDidLoad()
    
        
     imgMa[index] = image
      
       imageView.image = image
        repostLabel.text = String(repostsCount[index])
        if likesState[index] == 0{
            likeButton.setImage(unCheckedImage, for: .normal)
            likeButton.setTitle(String(likesTitle[i]), for: .normal)
          
            
        }
        else {
            likeButton.setImage(checkedImage, for: .normal)
            likeButton.setTitle(String(likesTitle[i]), for: .normal)
     
            
        }
        
     
        imageView.isUserInteractionEnabled = true
           if imgMa.count>1 {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeImage(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        imageView.addGestureRecognizer(swipeLeft)
      
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(swipeImage(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        imageView.addGestureRecognizer(swipeRight)
      
        
        }
    
        likeButton.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        let zoomImage = UIPinchGestureRecognizer(target: self, action: #selector(zoomInOutImage(sender:)))
        imageView.addGestureRecognizer(zoomImage)
      
    }
    
       @objc func buttonAction(sender:UIButton){
      isChecked = !isChecked
            if isChecked == true{
                if  likesState[index] == 1{
                    UIView.transition(with:sender, duration: 0.5, options: .transitionFlipFromTop, animations: {
                        sender.setImage(self.unCheckedImage, for: .normal)
                        sender.setTitle(String(self.likesTitle[self.index] - 1), for: .normal)
                    })
                    likesState[index] = 0
                  likesTitle[index] = likesTitle[index] - 1
                }
                    
             else {
                     UIView.transition(with:sender, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                        sender.setImage(self.checkedImage, for: .normal)
                        sender.setTitle(String(self.likesTitle[self.index] + 1), for: .normal)
                     })
                    likesState[index] = 1
                    likesTitle[index] = likesTitle[index] + 1
                }
        }
            else {
                if  likesState[index] == 0{
                    UIView.transition(with:sender, duration: 0.5, options: .transitionFlipFromTop, animations: {
                        sender.setImage(self.checkedImage, for: .normal)
                        sender.setTitle(String(self.likesTitle[self.index] + 1 ), for: .normal)
                    })
                    likesState[index] = 1
                    likesTitle[index] = likesTitle[index] + 1
                }
               else {
                    UIView.transition(with:sender, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                        sender.setImage(self.unCheckedImage, for: .normal)
                        sender.setTitle(String(self.likesTitle[self.index] - 1), for: .normal)
                    })
                   likesState[index] = 0
                   likesTitle[index] = likesTitle[index] - 1
                    
                }
               
        }
                
    }
    

    @objc func zoomInOutImage(sender:UIPinchGestureRecognizer){
        guard sender.view != nil else {
            return
        }
        if sender.state == .began || sender.state == .changed {
            sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
            sender.scale = 1.0
        }
    }
    
    
    @objc func swipeImage(_ sender: UISwipeGestureRecognizer) {
       
  
        switch sender.direction{
    
        case .left:
        
            if (index == imgMa.count-1) && (i == likesState.count-1){
                index = 0
                i = 0
                 imageView.image = imgMa[index]
            
                repostLabel.text = String(repostsCount[index])
            }
            else{
               
                index = index+1
                i = i + 1
                if(index>imgMa.count-1){
                    index=0
                    i=0
                }
                 imageView.image = imgMa[index]
                repostLabel.text = String(repostsCount[index])
            }
        
            leftTransition()
           
            
            if likesState[i] == 0 {
                likeButton.setImage(unCheckedImage, for: .normal)
                likeButton.setTitle(String(likesTitle[i]), for: .normal)
        
            }
            else {
                
                likeButton.setImage(checkedImage, for: .normal)
                likeButton.setTitle(String(likesTitle[i]), for: .normal)
            
            }
       
      
        case .right:
        
            if (index == 0) && (i == 0){
                index = imgMa.count-1
                i = likesState.count-1
                       imageView.image = imgMa[index]
                
                repostLabel.text = String(repostsCount[index])
            }
            else{
                index = index-1
                i = i-1
                if(index<0){
                    index = imgMa.count-1
                }
                       imageView.image = imgMa[index]
                
                repostLabel.text = String(repostsCount[index])
            }
            
            rightTransition()
            
          
    
            if likesState[i] == 0 {
             
                likeButton.setImage(unCheckedImage, for: .normal)
                likeButton.setTitle(String(likesTitle[i]), for: .normal)
          
                
            }
            else {
                likeButton.setImage(checkedImage, for: .normal)
                likeButton.setTitle(String(likesTitle[i]), for: .normal)
         
                
            }
         
        default: break
        }
        
    }
    
    
    func leftTransition(){
        
        let leftTransition = CATransition()
        leftTransition.type = CATransitionType.push
        leftTransition.subtype = CATransitionSubtype.fromRight
        leftTransition.duration = 0.35
        leftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        leftTransition.fillMode = CAMediaTimingFillMode.both
        imageView.layer.add(leftTransition, forKey: "leftTransition")
        imageView.transform = CGAffineTransform(scaleX:1, y: 1)
        
      
        
    }
    func rightTransition(){
        
        let rightTransition = CATransition()
        rightTransition.type = CATransitionType.push
        rightTransition.subtype = CATransitionSubtype.fromLeft
        rightTransition.duration = 0.35
        rightTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        rightTransition.fillMode = CAMediaTimingFillMode.both
        imageView.layer.add(rightTransition, forKey: "rightTransition")
        imageView.transform = CGAffineTransform(scaleX:0.92, y: 0.92)
        
    }

}


   
    


//
//  ViewController.swift
//  Animations
//
//  Created by Eduardo Carrillo on 4/12/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
   

    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)

        if (sender.state == .began){
           var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center // Initialize the new image on top of old smiley
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender: )))
            newlyCreatedFace.isUserInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(gesture)
            
            
            
        }else if (sender.state == .changed){
            
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)

            
        }else if(sender.state == .ended){
        
        }
        
    }
    func didPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        // User tapped at the point above. Do something with that if you want.
        
        if (sender.state == .began) {
            newlyCreatedFace = sender.view as! UIImageView
            //newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
        }
        else if (sender.state == .changed)
        {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        
        else if (sender.state == .ended) {}
    }
    
    
    
    
    @IBAction func didPanTry(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if (sender.state == .began){
            trayOriginalCenter = trayView.center
        }else if (sender.state == .changed){
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }else if(sender.state == .ended){
            var velocity = sender.velocity(in: view)
            if (velocity.y > 0){//Animating downwards
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayDown
                }, completion: nil)
            }else{
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayUp
                }, completion: nil)
            
            }
            
                   }
    }
    
    
    @IBOutlet weak var trayView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


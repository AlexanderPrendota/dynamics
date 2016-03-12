//
//  ViewController.swift
//  Dinamics
//
//  Created by Александр Прендота on 03.03.16.
//  Copyright © 2016 Александр Прендота. All rights reserved.
//

import UIKit


protocol UIDynamicItem : NSObjectProtocol {
    var center: CGPoint { get set }
    var bounds: CGRect { get }
    var transform: CGAffineTransform { get set }
}


class ViewController: UIViewController, UICollisionBehaviorDelegate {
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var square: UIView!
    var snap: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        square.backgroundColor = UIColor.blueColor()
        view.addSubview(square)
        
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
        barrier.backgroundColor = UIColor.greenColor()
        view.addSubview(barrier)
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: [square])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [square])
        collision.collisionDelegate = self
        collision.addBoundaryWithIdentifier("barrier", forPath: UIBezierPath(rect: barrier.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        let itemBehaviour = UIDynamicItemBehavior(items: [square])
        itemBehaviour.elasticity = 0.6
        animator.addBehavior(itemBehaviour)
        
        var updateCount = 0
        collision.action = {
            if (updateCount % 3 == 0) {
                let outline = UIView(frame: self.square.bounds)
                outline.transform = self.square.transform
                outline.center = self.square.center
                
                outline.alpha = 0.5
                outline.backgroundColor = UIColor.clearColor()
                outline.layer.borderColor = self.square.layer.presentationLayer()!.backgroundColor
                outline.layer.borderWidth = 1.0
                self.view.addSubview(outline)
            }
            
            ++updateCount
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


//
//  MenuViewController.swift
//  Streets
//
//  Created by Михаил Коновалов on 02.11.16.
//  Copyright © 2016 UripSoft. All rights reserved.
//

import UIKit
import Social
class MenuViewController: UIViewController {
    
    @IBOutlet weak var backgraundMaskView: UIView! //background размытие
    @IBOutlet weak var headerView: UIView! //header размытие
    @IBOutlet weak var bottomView: UIView! //bottom размытие
    @IBOutlet weak var userView: UIView! //панель кнопок user
    @IBOutlet weak var dialogView: AnimationView! //включает()
                                                  //headerView:
                                                  //bottomView:
                                                  //userView:
    @IBOutlet weak var shareView: AnimationView!
    @IBOutlet weak var shareButton: AnimationButton!
    @IBOutlet weak var twitterButton: AnimationButton!
    @IBOutlet weak var facebookButton: AnimationButton!
    @IBOutlet weak var twitterLabel: AnimationLabel!
    @IBOutlet weak var facebookLabel: AnimationLabel!
    @IBOutlet weak var maskButton: UIButton!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundDialogImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    ////////////////////////////////////////////////////////
    @IBAction func twitterShareButtonPress(_ sender: Any) {
        let twitterShare = SLComposeViewController(forServiceType:
            SLServiceTypeTwitter)
        twitterShare?.setInitialText("Привет от Urip")
        twitterShare?.add(UIImage(named: "avatar"))
        self.present(twitterShare!, animated: true, completion: nil)
        
    }
    
    @IBAction func facebookShareButtonPress(_ sender: Any) {
        let facebookShare = SLComposeViewController(forServiceType:
            SLServiceTypeFacebook)
        facebookShare?.setInitialText("Привет от Urip")
        facebookShare?.add(UIImage(named: "avatar2"))
        self.present(facebookShare!, animated: true, completion: nil)
    }
    
    var animator: UIDynamicAnimator!
    var attachmentBehavior: UIAttachmentBehavior!
    var snapBehavior: UISnapBehavior!
    
    @IBAction func shareButtonPress(_ sender: Any) {
        
        UIView.animate(withDuration: 0.1) { () -> Void in
            self.dialogView.frame = CGRect(x: 18, y: 102, width: 284, height: 225)
            self.userView.frame = CGRect(x: 50, y: 327, width: 220, height: 50)
            
        }
        
        shareView.isHidden = false
        shareView.nameAnimation = "fadeIn"
        shareView.animate()
        
        shareButton.nameAnimation = "shake"
        shareButton.animate()
        
        showMask()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7, options: .curveLinear, animations: { () -> Void in
                        self.dialogView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: nil)
        
        twitterButton.nameAnimation = "slideUp"
        twitterButton.delay = 0.5
        twitterButton.animate()
        
        twitterLabel.nameAnimation = "fadeIn"
        twitterLabel.delay = 0.6
        twitterLabel.animate()
        
        
        facebookButton.nameAnimation = "slideUp"
        facebookButton.delay = 0.7
        facebookButton.animate()
        
        facebookLabel.nameAnimation = "fadeIn"
        facebookLabel.delay = 0.8
        facebookLabel.animate()
        
        shareButton.isEnabled = false
    }
    
    func showMask() {
        maskButton.isHidden = false
        maskButton.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7, options:.curveEaseInOut, animations: { () -> Void in
                        self.maskButton.alpha = 1
        }, completion: nil)
    }
    
    
    
    @IBAction func maskButtomPress(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7, options: .curveLinear, animations: { () -> Void in
                        self.dialogView.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.maskButton.alpha = 0 }, completion: nil)
        //MARK: Убираем поповер
        shareView.nameAnimation = "fadeOut"
        shareView.animate()
        shareView.isHidden = false
        
        shareButton.isEnabled = true
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
        let translate = CGAffineTransform(translationX: 0, y: -300)
        
        dialogView.transform = scale.concatenating(translate)
        //Animate
        UIView.animate(withDuration: 0.5){ () -> Void in
            let scale = CGAffineTransform(scaleX: 1, y: 1)
            let translate = CGAffineTransform(translationX: 0, y: 0)
            self.dialogView.transform = scale.concatenating(translate)
        }
        
        backgroundImageView.image = UIImage( named: data [countRecord] ["image"]!)
        backgroundDialogImageView.image = UIImage( named: data [countRecord] ["image"]!)
        avatarImageView.image = UIImage( named: data [countRecord] ["avatar"]!)
        titleLabel.text = data[countRecord] ["title"]
        
        dialogView.alpha = 1
    }
    
    var data = getData()
    var countRecord = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Blur Effect
        addBlurEffect(view: backgraundMaskView, style: .dark)
        addBlurEffect(view: headerView, style: .dark)
        addBlurEffect(view: bottomView, style: .dark)
        //        UIAttachmentBehavior
        //        UICollisionBehavior
        //        UIGravityBehavior
        //        UIPushBehavior
        //        UISnapBehavior
        //        UIDynamicAnimator
        animator = UIDynamicAnimator(referenceView: view)
        snapBehavior = UISnapBehavior(item: dialogView, snapTo: view.center)
        
        dialogView.alpha = 0
    }
    
    @IBAction func handleRecognizer(_ sender: Any) {
        let myView = dialogView
        let location = (sender as AnyObject).location(in: view)
        let boxLocation = (sender as AnyObject).location(in: dialogView)
        
        if (sender as AnyObject).state == UIGestureRecognizerState.began{
            animator.removeBehavior(snapBehavior)
            
            let centerOffset = UIOffsetMake(boxLocation.x - (myView?.bounds)!.midX, boxLocation.y - (myView?.bounds)!.midY)
            attachmentBehavior = UIAttachmentBehavior(item: myView!, offsetFromCenter: centerOffset, attachedToAnchor: location)
            attachmentBehavior.frequency = 0
            animator.addBehavior(attachmentBehavior)
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.userView.frame = CGRect(x: 50, y: 395, width: 220, height: 50)
            })
            
            
        }
        else if (sender as AnyObject).state == UIGestureRecognizerState.changed{
            attachmentBehavior.anchorPoint = location
        }
        else if (sender as AnyObject).state == UIGestureRecognizerState.ended{
            animator.removeBehavior(attachmentBehavior)
            snapBehavior = UISnapBehavior(item: myView!, snapTo: view.center)
            animator.addBehavior(snapBehavior)
            
            let translate = (sender as AnyObject).translation(in: view)
            if  translate.x > 200 {
                animator.removeAllBehaviors()
                
                let gravity = UIGravityBehavior(items: [dialogView])
                gravity.gravityDirection = CGVector(dx: 10, dy: 0)
                animator.addBehavior(gravity)
                
                refreshView()
            }
        }
    }
    
    //MARK: Helper Method
    //Размытие фона
    
    func addBlurEffect(view: UIView, style: UIBlurEffectStyle) {
        
        view.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.insertSubview(blurEffectView, at: 0)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func refreshView() {
        
        countRecord += 1
        if countRecord > 2 {
            countRecord = 0
        }
        
        animator.removeAllBehaviors()
        snapBehavior = UISnapBehavior(item: dialogView, snapTo: view.center)
        attachmentBehavior.anchorPoint = view.center
        
        dialogView.center = view.center
        viewDidAppear(true)
    }
}

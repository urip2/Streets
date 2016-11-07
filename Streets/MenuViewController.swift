//
//  MenuViewController.swift
//  Streets
//
//  Created by Михаил Коновалов on 02.11.16.
//  Copyright © 2016 UripSoft. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var backgraundMaskView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var dialogView: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
        let translate = CGAffineTransform(translationX: 0, y: -300)
        dialogView.transform = scale.concatenating(translate)
        //Animate
        UIView.animate(withDuration: 0.7){
            let scale = CGAffineTransform(scaleX: 1, y: 1)
            let translate = CGAffineTransform(translationX: 0, y: 0)
            self.dialogView.transform = scale.concatenating(translate)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set Blur Effect
        addBlurEffect(view: backgraundMaskView, style: .dark)
        addBlurEffect(view: headerView, style: .dark)
        addBlurEffect(view: bottomView, style: .dark)
        
    }
    //Размытие фона
    
    func addBlurEffect(view: UIView, style: UIBlurEffectStyle)   {
        
        view.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.insertSubview(blurEffectView, at: 0)
    }
    
    
   override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    

}

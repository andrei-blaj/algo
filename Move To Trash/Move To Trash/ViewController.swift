//
//  ViewController.swift
//  Move To Trash
//
//  Created by Andrei Blaj on 3/9/20.
//  Copyright © 2020 Andrei Blaj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fileImageView: UIImageView!
    @IBOutlet weak var trashImageView: UIImageView!
    
    var fileViewOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPanGestureRecognizer(view: fileImageView)
        fileViewOrigin = fileImageView.frame.origin
        view.bringSubviewToFront(fileImageView)
    }

    func addPanGestureRecognizer(view: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(_:)))
        view.addGestureRecognizer(panGesture)
    }

    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let fileView = sender.view!
        let translation = sender.translation(in: self.view)
        
        switch sender.state {
        case .began, .changed:
            fileView.center = CGPoint(x: fileView.center.x + translation.x, y: fileView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
        case .ended:
            
            if fileImageView.frame.intersects(trashImageView.frame) {
                UIView.animate(withDuration: 0.3) {
                    self.fileImageView.alpha = 0.0
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.fileImageView.frame.origin = self.fileViewOrigin
                }
            }

        default:
            break
        }
    }
    
}


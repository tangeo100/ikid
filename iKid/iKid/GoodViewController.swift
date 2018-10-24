//
//  GoodViewController.swift
//  iKid
//
//  Created by Ronald Tang on 10/22/18.
//  Copyright © 2018 Ronald Tang. All rights reserved.
//

import UIKit

class GoodViewController: UIViewController {

    fileprivate var joke : GoodJokeView!
    fileprivate var resolve : GoodResolveViewController!
    
    fileprivate func jokeBuilder() {
        if joke == nil {
            joke =
                (storyboard?
                    .instantiateViewController(withIdentifier: "GoodJoke")
                    as! GoodJokeView)
        }
    }
    fileprivate func resolveBuilder() {
        if resolve == nil {
            resolve =
                (storyboard?
                    .instantiateViewController(withIdentifier: "GoodResolve")
                    as! GoodResolveViewController)
        }
    }
    
    @IBAction func switchViews(_ sender: Any) {
        resolveBuilder()
        jokeBuilder()
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)
        
        if joke != nil && joke?.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            resolve.view.frame = view.frame
            switchViewController(joke, to: resolve)
        }
        else {
            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
            joke.view.frame = view.frame
            switchViewController(resolve, to: joke)
        }
        
        UIView.commitAnimations()
    }
    
    fileprivate func switchViewController(_ from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMove(toParent: nil)
            from!.view.removeFromSuperview()
            from!.removeFromParent()
        }
        
        if to != nil {
            self.addChild(to!)
            self.view.insertSubview(to!.view, at: 0)
            to!.didMove(toParent: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        jokeBuilder()
        switchViewController(nil, to: joke)
    }

}

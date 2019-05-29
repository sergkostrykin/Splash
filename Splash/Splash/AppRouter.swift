//
//  AppRouter
//  MovieDB
//
//  Created by Sergiy Kostrykin on 5/16/19.
//  Copyright © 2019 MWDN. All rights reserved.
//

import UIKit

class AppRouter: NSObject {
    
    // MARK: - Properties
    let window: UIWindow?
    
    // MARK: - init
    init? (window: UIWindow?) {
        self.window = window
        super.init()
        if window == nil {
            print("AppRouter Error")
            return nil
        }
        setupAppearance()
        showAppropriateView()
    }
    
    private func showAppropriateView() {
        let navigation = UINavigationController(rootViewController: UIViewController())
        navigation.setNavigationBarHidden(true, animated: false)
        MovieListScreen().push(to: navigation, animated: false)
        animateTransition(to: navigation)
    }
    
    private func animateTransition(to controller: UIViewController) {
        guard let window = window else {
            return
        }
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = controller
        }, completion: { completed in
        })
    }


    
    private func setupAppearance() {
        let backButtonImage: UIImage? = {
            let backIcon = UIImage(named: "back")!
            let leftOffset: CGFloat = 8.0
            let size = CGSize(width: backIcon.size.width + leftOffset, height: backIcon.size.height + 15)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            backIcon.draw(at: CGPoint(x: leftOffset, y: 3))
            let res = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return res
        }()
        
        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        UINavigationBar.appearance().tintColor = .white
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset.init(horizontal: -60, vertical: -60), for: .default)
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().tintColor = UIColor.black
    }


    
}

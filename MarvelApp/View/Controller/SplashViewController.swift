//
//  SplashViewController.swift
//  MarvelApp
//
//  Created by Doğuş Hür on 23.11.2021.
//

import UIKit
import RevealingSplashView

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSplash()
    }
    
    func setupSplash(){
        
        let SplashView = RevealingSplashView(iconImage: UIImage(named: "marvel_logo")!,iconInitialSize: CGSize(width: 300, height: 145), backgroundColor: UIColor.white)
        self.view.addSubview(SplashView)
        SplashView.startAnimation(){
            self.startApp()
        }
        
    }
    
    func startApp(){
        let viewController = CharactersController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
}
    

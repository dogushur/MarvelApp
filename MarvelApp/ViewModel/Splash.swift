//
//  Splash.swift
//  MarvelApp
//
//  Created by Doğuş Hür on 23.11.2021.
//

import Foundation
import RevealingSplashView

struct Splash{
    
    func splashStart(){
        let SplashView = RevealingSplashView(iconImage: UIImage(named: "marvel_logo")!,iconInitialSize: CGSize(width: 300, height: 145), backgroundColor: UIColor.white)
        self.view.addSubview(SplashView)
        SplashView.startAnimation(){
            print("Completed")
        }
    }
    
}

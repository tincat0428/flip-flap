//
//  FlashViewController.swift
//  App
//
//  Created by shine on 2023/6/16.
//

import Foundation
import UIKit
import Capacitor

class FlashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //設定背景圖
        let backgroundImage = UIImageView(image: UIImage(named:"background"))
        let screenSize = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        backgroundImage.frame = screenSize
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.alpha = 0.3
        //將背景圖包進view container
        view.addSubview(backgroundImage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "isFirebase") == nil
        {
            self.showFlash()
        }
    }
    
    func showFlash() {
        let vc = CAPBridgeViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

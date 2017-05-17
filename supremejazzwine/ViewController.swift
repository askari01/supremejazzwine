//
//  ViewController.swift
//  supremejazzwine
//
//  Created by Syed Askari on 17/04/2017.
//  Copyright © 2017 Supreme Jazz Wine. All rights reserved.
//

import UIKit
import SystemConfiguration 

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidAppear(_ animated: Bool) {
        if isConnectedToNetwork() {
            if let url = URL(string: "https://supremejazzwine.com/") {
                let request = URLRequest(url: url)
                webView.loadRequest(request)
            }
        } else {
            print ("no internet")
            let alertController = UIAlertController(title: "Error", message: "Bad Internet Found.", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
            
            let reloadAction = UIAlertAction(title: "Reload", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                print("Reload")
                self.reload()
            }
            
            alertController.addAction(reloadAction)
            self.present(alertController, animated: true, completion:nil )
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)}
        } ) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
        
    }
    
    
    func reload() {
        if isConnectedToNetwork() {
            if let url = URL(string: "http://entekhabman.com/") {
                let request = URLRequest(url: url)
                webView.loadRequest(request)
            }
        } else {
            print ("no internet")
            let alertController = UIAlertController(title: "Error", message: "Bad Internet Found.", preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
            
            let reloadAction = UIAlertAction(title: "Reload", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                print("Reload")
                self.reload()
            }
            
            alertController.addAction(reloadAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }

}


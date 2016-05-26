//
//  ViewController.swift
//  APIKit-iOS7
//
//  Created by Shinichiro Oba on 5/25/16.
//  Copyright © 2016 Shinichiro Oba. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonPushed(sender: AnyObject) {
        //: Step 4: Send request
        let request = GetRateLimitRequest()
        
        activityIndicator.startAnimating()
        
        Session.sendRequest(request) { [weak self] result in
            self?.activityIndicator.stopAnimating()
            
            switch result {
            case .Success(let rateLimit):
                self?.label.text = "count: \(rateLimit.count)\nreset: \(rateLimit.resetDate)"
                
            case .Failure(let error):
                self?.label.text = "error: \(error)"
            }
        }
    }
}

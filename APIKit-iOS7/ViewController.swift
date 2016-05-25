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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonPushed(sender: AnyObject) {
        //: Step 4: Send request
        let request = GetRateLimitRequest()
        
        Session.sendRequest(request) { [weak self] result in
            switch result {
            case .Success(let rateLimit):
                self?.label.text = "count: \(rateLimit.count)\nreset: \(rateLimit.resetDate)"
                
            case .Failure(let error):
                self?.label.text = "error: \(error)"
            }
        }
    }
}

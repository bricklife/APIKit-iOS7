//
//  GitHubAPI.swift
//  APIKit-iOS7
//
//  Created by Shinichiro Oba on 5/25/16.
//  Copyright © 2016 Shinichiro Oba. All rights reserved.
//

import Foundation

//: Step 1: Define request protocol
protocol GitHubRequestType: RequestType {
    
}

extension GitHubRequestType {
    var baseURL: NSURL {
        return NSURL(string: "https://api.github.com")!
    }
}

//: Step 2: Create model object
struct RateLimit {
    let count: Int
    let resetDate: NSDate
    
    init?(dictionary: [String: AnyObject]) {
        guard let count = dictionary["rate"]?["limit"] as? Int else {
            return nil
        }
        
        guard let resetDateString = dictionary["rate"]?["reset"] as? NSTimeInterval else {
            return nil
        }
        
        self.count = count
        self.resetDate = NSDate(timeIntervalSince1970: resetDateString)
    }
}

//: Step 3: Define request type conforming to created request protocol
// https://developer.github.com/v3/rate_limit/
struct GetRateLimitRequest: GitHubRequestType {
    typealias Response = RateLimit
    
    var method: HTTPMethod {
        return .GET
    }
    
    var path: String {
        return "/rate_limit"
    }
    
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        guard let dictionary = object as? [String: AnyObject],
            let rateLimit = RateLimit(dictionary: dictionary) else {
                throw ResponseError.UnexpectedObject(object)
        }
        
        return rateLimit
    }
}
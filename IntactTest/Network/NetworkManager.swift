//
//  NetworkManager.swift
//  IntactTest
//
//  Created by Shahab Chaouche on 2020-09-05.
//  Copyright © 2020 Shahab Chaouche. All rights reserved.
//

import Alamofire
import Foundation

struct NetworkManager {
    
    static func requestData(url: URL, completion: @escaping (_ data: [String:Any]) -> Void) {
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON(completionHandler: { response in
                guard response.result.isSuccess else {
                    print("Error fetching data")
                    return
                }
                
                guard let value = response.result.value as? [String: Any] else {
                    print("incorrect data received")
                    return
                }
                completion(value)
            })
    }
}

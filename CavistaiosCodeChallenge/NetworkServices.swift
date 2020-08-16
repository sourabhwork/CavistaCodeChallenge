//
//  NetworkServices.swift
//  CavistaiosCodeChallenge
//
//  Created by Sourabh Kumbhar on 12/08/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import Foundation
import Alamofire


class NetworkSerives {
    
    weak var delegate: NetworkServicesDelegate?
    
    func fetchData() {
        let request = AF.request(ConstantHelper.networkUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: .none).validate().responseJSON {
                    response in
            
            switch response.result {
                
            case .success(_):
                if let data = response.data {
                    do {
                        // Parsing data using codable and pass data to viewcontroller through delegate
                        let responseDataArray = try JSONDecoder().decode([ResponseDataModel].self, from: data)
                        self.delegate?.didGetData(dataModelArray: responseDataArray)
                    } catch let error {
                        self.delegate?.didGetError(error: error.localizedDescription)
                    }
                }
            case .failure(let error):
                self.delegate?.didGetError(error: error.localizedDescription)
            }
        }
        print(request.description)
    }
}


class Connectivity {
    
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

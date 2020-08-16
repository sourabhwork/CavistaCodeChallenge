//
//  NetworkServicesDelegate.swift
//  CavistaiosCodeChallenge
//
//  Created by Sourabh Kumbhar on 12/08/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import Foundation

protocol NetworkServicesDelegate: class {
    func didGetData(dataModelArray: Array<ResponseDataModel>)
    func didGetError(error: String)
}

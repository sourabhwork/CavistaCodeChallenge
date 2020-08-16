//
//  ResponseDataRealmModel.swift
//  CavistaiosCodeChallenge
//
//  Created by Sourabh Kumbhar on 16/08/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import Foundation
import RealmSwift

class ResponseDataRealmModel: Object {
    
    @objc dynamic var id  : String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var data: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

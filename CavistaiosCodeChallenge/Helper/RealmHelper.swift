//
//  RealmHelper.swift
//  CavistaiosCodeChallenge
//
//  Created by Sourabh Kumbhar on 16/08/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    static let realm = try? Realm()
    
    //Save array of objects to database
    class func saveObject(object: Object) {
        try! realm?.write ({
            print(object)
            realm?.add(object, update: .modified)
        })
    }
    
    class func getResponseDataRealmModel()-> Results<ResponseDataRealmModel> {
        return realm!.objects(ResponseDataRealmModel.self)
    }
    
    class func storeResponseData(responseDataArray: Array<ResponseDataModel>) {
        for responseData in responseDataArray {
            let responseDataRealmModel = ResponseDataRealmModel()
            responseDataRealmModel.id = responseData.id ?? ""
            responseDataRealmModel.data = responseData.data ?? ""
            responseDataRealmModel.date = responseData.date ?? ""
            responseDataRealmModel.type = responseData.type ?? ""
            self.saveObject(object: responseDataRealmModel)
        }
    }
    
    class func getResponseData()->Array<ResponseDataModel> {
        var responseDataModelArray = Array<ResponseDataModel>()
        let responseDataRealmModelArray = getResponseDataRealmModel()
        for responseData in responseDataRealmModelArray {
            let responseDataModel = ResponseDataModel()
            responseDataModel.id = responseData.id
            responseDataModel.data = responseData.data
            responseDataModel.date = responseData.date
            responseDataModel.type = responseData.type
            responseDataModelArray.append(responseDataModel)
        }
        return responseDataModelArray
    }
    
}

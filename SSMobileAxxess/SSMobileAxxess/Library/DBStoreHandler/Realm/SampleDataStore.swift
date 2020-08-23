//
//  SampleDataStore.swift
//  SSMobileAxxess
//
//  Created by Siddhant on 21/08/20.
//  Copyright © 2020 Siddhant. All rights reserved.
//

import Foundation
import RealmSwift

class SampleDataStore {
    var realm:Realm = try! Realm()
    
    public func saveComicBook(_ sampleData: SampleData)
    {
        
        try! realm.write {
            realm.add(sampleData)
        }
    }
    
    public func isRealmExist() -> Bool
    {
        return realm.isEmpty
    }
    
    public func deleteAllData()  {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    public func getAllObjects() -> [SampleData] {
        let defaultRealm = try! Realm()
        let objects = defaultRealm.objects(SampleData.self).toArray(ofType: SampleData.self) as [SampleData]
        return objects
    }
    
    public func makeNewSampleData(_ id: String, type: String, date: String, data: String ) -> SampleData
    {
        let sampleData = SampleData()
        sampleData.id = id
        sampleData.type = type
        sampleData.date = date
        sampleData.data = data
        return sampleData
    }
    
    public func findSampleDataByType(_ type: String) -> Results<SampleData>
    {
        let predicate = NSPredicate(format: "type= %@", type)
        return realm.objects(SampleData.self).filter(predicate)
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        return array
    }
}

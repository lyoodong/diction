//
//  CRUDManager.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/25.
//

import Foundation
import RealmSwift

class CRUDManager: RealmCRUD{

    static let shared = CRUDManager()
    private init() { }
    
    let realm = try! Realm()
    
    func read<T: Object>(object: T.Type) -> Results<T> {
        return realm.objects(object)
    }
    
    func readSorted<T: Object>(object: T.Type, bykeyPath: String?, ascending:Bool) -> Results<T> {
        return realm.objects(object).sorted(byKeyPath: bykeyPath!, ascending: ascending)
    }
    
    func write<T: Object>(object: T)  {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("write에러 발생")
        }
    }
    
    func update<T: Object>(object: T)  {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            print("update에러 발생")
        }
    }
    
    
    func delete<T: Object>(object: T)  {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("delete에러 발생")
        }
    }
    
    func filterByObjcID<T: Object>(object: T.Type, key: String, objectID: Any) -> Results<T> {
        return realm.objects(object).filter("\(key) == %@", objectID)
    }
    
    func realmFileLocation() {
        print("=====Realm 경로: ", realm.configuration.fileURL!)
    }
    
    //    https://velog.io/@hope1053/iOS-Realm-3-Sort-Filter
}

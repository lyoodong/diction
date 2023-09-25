//
//  CRUDManager.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/25.
//

import Foundation
import RealmSwift

class RealmRepository {
    
    var realm = try! Realm()

    func read<T: Object>(object: T.Type, readtype: ReadType, bykeyPath: String?) -> Results<T> {
        
        if readtype == .read {
            return realm.objects(object)
        } else if readtype == .sort {
            return realm.objects(object).sorted(byKeyPath: bykeyPath!, ascending: true)
        } else {
            return realm.objects(object).filter("error")
        }
    }
    
    func write<T: Object>(object: T, writetype: WriteType )  {
        
        switch writetype {
        case .add:
            do {
                try realm.write {
                    realm.add(object)
                }
            } catch {
                print(error)
            }
        case .update:
            do {
                try realm.write {
                    realm.add(object, update: .modified)
                }
            } catch {
                print(error)
            }
            
        }
    }
    
    func delete<T: Object>(object: T)  {
        
        try! realm.write {
            realm.delete(object)
            
        }
    }

    func realmFileLocation() {
        print("=====Realm 경로: ", realm.configuration.fileURL!)
    }
}

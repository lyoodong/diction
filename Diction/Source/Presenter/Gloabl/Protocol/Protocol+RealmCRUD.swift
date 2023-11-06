//
//  File.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/25.
//

import Foundation
import RealmSwift

protocol RealmCRUD {
    func read<T: Object>(object: T.Type) -> Results<T>
    func readSorted<T: Object>(object: T.Type, bykeyPath: String?, ascending:Bool) -> Results<T>
    func write<T: Object>(object: T)
    func update<T: Object>(object: T)
    func delete<T: Object>(object:T)
}

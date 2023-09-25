//
//  File.swift
//  GreenLight
//
//  Created by Dongwan Ryoo on 2023/09/25.
//

import Foundation
import RealmSwift

protocol RealmCRUD {
    func read<T: Object>(object:T.Type, readtype: ReadType, bykeyPath: String?) -> Results<T>
    func write<T: Object>(object:T, writetype: WriteType)
    func delete<T: Object>(object:T)
}

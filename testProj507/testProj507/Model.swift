//
//  Model.swift
//  testProj507
//
//  Created by Andy W on 06/07/2022.
//

import Foundation
import RealmSwift

class testDatum: Object {
    @Persisted(primaryKey: true) var _id: ObjectId?
    @Persisted var managers: List<String>
    @Persisted var test: String?
}


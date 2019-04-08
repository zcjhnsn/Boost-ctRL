//
//  RealmObjects.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 3/4/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Realm Team object
class RealmTeam: Object {
	@objc dynamic var id: String = ""
	@objc dynamic var region: Int = 0
	@objc dynamic var name: String = ""
	@objc dynamic var abbreviatedName: String = ""
	@objc dynamic var player1: String = ""
	@objc dynamic var player2: String = ""
	@objc dynamic var player3: String = ""
	@objc dynamic var standing: Int = 0
	@objc dynamic var win: String = ""
	@objc dynamic var loss: String = ""
	@objc dynamic var gameDifferential: Int = 0
	@objc dynamic var backgroundColor: String = ""
	
	override static func primaryKey() -> String? {
		return "id"
	}
}

//////////////////////////////////////////////

// MARK: - Realm RLCS Match Object

class RealmMatchRLCS: Object {
	@objc dynamic var id: String = ""
	@objc dynamic var week: Int = 1
	@objc dynamic var region: Int = 0
	@objc dynamic var teamOneID: String = ""
	@objc dynamic var teamTwoID: String = ""
	@objc dynamic var oneScore: String = ""
	@objc dynamic var twoScore: String = ""
	@objc dynamic var date: String = ""
	@objc dynamic var title: String = ""
	
	override static func primaryKey() -> String? {
		return "id"
	}
}

//////////////////////////////////////////////

// MARK: - Realm RLRS Match Object

class RealmMatchRLRS: Object {
	@objc dynamic var id: String = ""
	@objc dynamic var week: Int = 1
	@objc dynamic var region: Int = 3
	@objc dynamic var teamOneID: String = ""
	@objc dynamic var teamTwoID: String = ""
	@objc dynamic var oneScore: String = ""
	@objc dynamic var twoScore: String = ""
	@objc dynamic var date: String = ""
	@objc dynamic var title: String = ""
	
	override static func primaryKey() -> String? {
		return "id"
	}
}

//////////////////////////////////////////////

// MARK: - Writing Objects to Realms


extension RealmTeam {
	func writeToRealm() {
		try! teamRealm.write {
			teamRealm.add(self, update: true)
		}
	}
}

extension RealmMatchRLCS {
	func writeToRLCSRealm() {
		try! rlcsRealm.write {
			rlcsRealm.add(self, update: true)
		}
	}
}

extension RealmMatchRLRS {
	func writeToRLRSRealm() {
		try! rlrsRealm.write {
			rlrsRealm.add(self, update: true)
		}
	}
}

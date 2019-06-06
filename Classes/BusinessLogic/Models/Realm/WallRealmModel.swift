//
//  Created by Dmitriy Verennik on 06/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import Foundation
import RealmSwift

final class WallRealmModel: Object {
    @objc dynamic var postID: Int = 0
    @objc dynamic var username: String = ""
    @objc dynamic var date = Date()
    @objc dynamic var text: String = ""
    @objc dynamic var photoStringURL: String = ""
    @objc dynamic var photoWidth: Int = 0
    @objc dynamic var photoHeight: Int = 0
    @objc dynamic var likesNumber: Int = 0
    @objc dynamic var isLikeIt: Bool = false
    @objc dynamic var repostsNumber: Int = 0
    @objc dynamic var userAvatarStringURL: String = ""

    override static func primaryKey() -> String? {
        return "postID"
    }
}

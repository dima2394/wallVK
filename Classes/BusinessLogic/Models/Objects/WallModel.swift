//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import RealmSwift
import ObjectMapper

final class WallModel: Mappable {
    var id: Int = 0
    var fromID: Int = 0
    var likes: LikesModel?
    var reposts: RepostsModel?
    var ownerID: Int = 0
    var date: Date!
    var text: String = ""
    var attachments: [AttachmentModel] = []

    required init?(map: Map) {}

    func mapping(map: Map) {
        id              <- map["id"]
        fromID          <- map["from_id"]
        likes           <- map["likes"]
        reposts         <- map["reposts"]
        ownerID         <- map["owner_id"]
        date            <- (map["date"], DateTransform())
        text            <- map["text"]
        attachments     <- map["attachments"]
    }
}

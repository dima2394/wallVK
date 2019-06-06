//
//  Created by Dmitriy Verennik on 06/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import VKSdkFramework
import RealmSwift

final class VKService: VKServiceProtocol {


    let realmService: RealmServiceProtocol

    init(realmService: RealmServiceProtocol) {
        self.realmService = realmService
    }

    func fetchWall() {
        VKApi.request(withMethod: "wall.get", andParameters: [:])?.execute(resultBlock: { response in
            if let jsonResponse = response?.json as? [String: Any] {
                guard let wallItems = WallResponse(JSON: jsonResponse)?.wallItems else {
                    return
                }

                do {
                    try self.realmService.realm.write {
                        self.realmService.realm.deleteAll()
                    }
                } catch (let error) {
                    print(error.localizedDescription)
                }
                for wallItem in wallItems {
                    let wall = WallRealmModel()
                    wall.postID = wallItem.id
                    var firstname = ""
                    var lastname = ""
                    if let firstName = VKSdk.accessToken()?.localUser.first_name {
                        firstname = firstName
                    }
                    if let lastName = VKSdk.accessToken()?.localUser.last_name {
                        lastname = lastName
                    }

                    wall.username = "\(firstname) \(lastname)"
                    wall.date = wallItem.date
                    wall.text = wallItem.text
                    if let photo = wallItem.attachments.first?.photo {
                        wall.photoStringURL = photo.url
                        wall.photoWidth = photo.width
                        wall.photoHeight = photo.height
                    }
                    if let like = wallItem.likes {
                        wall.likesNumber = like.count
                        wall.isLikeIt = like.iLikedIt
                    }
                    if let reposts = wallItem.reposts {
                        wall.repostsNumber = reposts.count
                    }
                    if let userAvatarStringURL = VKSdk.accessToken()?.localUser.photo_200 {
                        wall.userAvatarStringURL = userAvatarStringURL
                    }

                    do {
                        try self.realmService.realm.write {
                            self.realmService.realm.add(wall, update: .all)
                        }
                    } catch (let error) {
                        print(error.localizedDescription)
                    }
                }
            }
        }, errorBlock: { error in
            if let localizedDescription = error?.localizedDescription {
                print(localizedDescription)
            }
        })
    }

    func observeWallItems(withHandler handler: @escaping (RealmCollectionChange<Results<WallRealmModel>>) -> Void) -> NotificationToken {
        return realmService.observeWallItems(withHandler: handler)
    }
}

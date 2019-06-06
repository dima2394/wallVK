//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

typealias HasServices = HasRealmService &
                        HasVKService

private typealias HasPersistentServices = HasRealmService

// MARK: - Singletone Services

private final class PersistentServiceContainer: HasPersistentServices {

    static var instance: PersistentServiceContainer = .init()

    var realmService: RealmServiceProtocol {
        return RealmService()
    }
    
    private init() {}
}

// MARK: - Regular Services

final class ServiceContainer: HasServices {

    var realmService: RealmServiceProtocol {
        return PersistentServiceContainer.instance.realmService
    }

    var vkService: VKServiceProtocol {
        return VKService(realmService: realmService)
    }
}

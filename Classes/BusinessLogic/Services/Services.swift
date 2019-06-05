//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

typealias HasServices = Any

private typealias HasPersistentServices = Any

// MARK: - Singletone Services

private final class PersistentServiceContainer: HasPersistentServices {

    static var instance: PersistentServiceContainer = .init()
    
    private init() {}
    
    /// Lazy service instances with dependencies from regular service container
    ///
    /// lazy var sessionService: SessionServiceProtocol = {
    ///     return SessionService(keychainService: ServiceContainer().keychainService)
    /// }()
}

// MARK: - Regular Services

final class ServiceContainer: HasServices {
    
    /// lazy var keychainService: KeychainServiceProtocol = {
    ///     return KeychainService()
    /// }()
    
    /// var sessionService: SessionServiceProtocol {
    ///     return PersistentServiceContainer.instance.sessionService
    /// }
}

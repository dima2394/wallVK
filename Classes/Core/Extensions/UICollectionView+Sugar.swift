//
//  Created by Dmitriy Verennik on 06/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit

extension UICollectionView {

    func registerCellClass(_ cellClass: AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable cell for indexPath: \((indexPath.section, indexPath.item))")
        }
        return cell
    }
}

//
//  Created by Dmitriy Verennik on 06/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit

extension UICollectionView {

    func registerCellClass(_ cellClass: AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }

    func registerFooterViewClass(_ viewClass: AnyClass) {
        register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: String(describing: viewClass) + ".Footer")
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable cell for indexPath: \((indexPath.section, indexPath.item))")
        }
        return cell
    }

    func dequeueReusableFooterView<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                          withReuseIdentifier: String(describing: T.self) + ".Footer",
                                                          for: indexPath) as? T else {
                                                            fatalError("Unable to dequeue reusable footer for indexPath: \((indexPath.section, indexPath.item))")
        }
        return view
    }
}

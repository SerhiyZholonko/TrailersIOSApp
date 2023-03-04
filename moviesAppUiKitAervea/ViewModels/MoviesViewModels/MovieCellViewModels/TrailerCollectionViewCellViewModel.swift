//
//  TrailerCollectionViewCellViewModel.swift
//  moviesAppUiKitAervea
//
//  Created by apple on 30.01.2023.
//

import UIKit

struct TrailerCollectionViewCellViewModel {
    private let image: UIImage?

    init(image: UIImage?) {
        self.image = image
    }
    func getImage() -> UIImage? {
        return image
    }

}

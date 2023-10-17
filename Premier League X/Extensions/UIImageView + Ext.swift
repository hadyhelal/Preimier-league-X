//
//  DownloadUIimage + Ext.swift
//
//  Premier League X
//
//  Created by Hady on 15/10/2023.

import UIKit
import Kingfisher
import SVGKit

extension UIImageView {
    func downloadImage(url: String?, placeholderImg: UIImage = UIImage(), withPlaceholder: Bool = true) {
        self.kf.indicatorType = .activity

        guard let imageUrl  = URL(string: url ?? "") else {
            self.contentMode = .scaleAspectFill
            self.image = nil
            return
        }
        
        guard url!.hasSuffix("svg") == false else {
            self.kf.setImage(with: imageUrl, options: [.processor(SVGImgProcessor())])
            return
        }
        

        
        
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 10)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: imageUrl,
            placeholder: nil,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            _ in

        }

    }

}

public struct SVGImgProcessor:ImageProcessor {
    public var identifier: String = "com.appidentifier.webpprocessor"
    public func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            print("already an image")
            return image
        case .data(let data):
            let imsvg = SVGKImage(data: data)
            return imsvg?.uiImage
        }
    }
}

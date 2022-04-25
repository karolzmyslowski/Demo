//
//  ImageCache.swift
//  FutureMindApp
//
//  Created by Karol Zmysłowski on 28/03/2022.
//

import Foundation
import UIKit.UIImage
import Combine

protocol ImageCacheType: AnyObject {
    
    func image(for url: URL) -> UIImage?
    func insertImage(_ image: UIImage?, for url: URL)
    func removeImage(for url: URL)
    func removeAllImages()
    subscript(_ url: URL) -> UIImage? { get set }
}

class ImageCache: ImageCacheType {

    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = countLimit
        return cache
    }()

    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = memoryLimit
        return cache
    }()
    private let lock = NSLock()

    let countLimit: Int = 100
    let memoryLimit: Int = 1024 * 1024 * 100

    func image(for url: URL) -> UIImage? {
        lock.lock(); defer { lock.unlock() }
        if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
            return decodedImage
        }
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decodedImage.diskSize)
            return decodedImage
        }
        return nil
    }

    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return removeImage(for: url) }
        let decompressedImage = image.decodedImage()

        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(decompressedImage, forKey: url as AnyObject, cost: 1)
        decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject, cost: decompressedImage.diskSize)
    }

    func removeImage(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: url as AnyObject)
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }

    func removeAllImages() {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeAllObjects()
        decodedImageCache.removeAllObjects()
    }

    public subscript(_ key: URL) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            return insertImage(newValue, for: key)
        }
    }
}

fileprivate extension UIImage {

    func decodedImage() -> UIImage {
        guard let cgImage = cgImage else { return self }
        let size = CGSize(width: cgImage.width, height: cgImage.height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: cgImage.bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
        guard let decodedImage = context?.makeImage() else { return self }
        return UIImage(cgImage: decodedImage)
    }

    var diskSize: Int {
        guard let cgImage = cgImage else { return 0 }
        return cgImage.bytesPerRow * cgImage.height
    }
}

//
//  ImagesHelper.swift
//  WarStat
//
//  Created by a.antoniak on 21.09.2023.
//

import UIKit

final class SomeType: Sendable {
    let count = 1
}

struct SomeStruct {
    let integer: Int
    let someType: SomeType
}

actor Actor {
    var someStruct: SomeStruct?
}

struct ImagesHelper {
    var sharedData: String
    
    func fetchImages() async -> [UIImage] {
        let someImageUrlString = "someUrl"
        
        async let imageURLStrings = loadImageURLs(someImageUrlString)
        async let otherIndependentData = loadSomeOtherIndependentStuff(someImageUrlString)
        
        let imageUrls = await imageURLStrings.compactMap { URL(string: $0) }
        
        return await loadImages(imageUrls)
    }
    
    private func loadImageURLs(_ urlString: String) async -> [String] {
        guard let url = URL(string: urlString) else { return [] }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            print("response - \(response)")
            print("data - \(data)")
            
            return []
        } catch {
            return []
        }
    }
    
    private func loadSomeOtherIndependentStuff(_ urlString: String) async -> String? {
        guard let url = URL(string: urlString) else { return "" }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            print("response - \(response)")
            print("data - \(data)")
            
            return ""
        } catch {
            return nil
        }
    }
    
    private func loadImages(_ urls: [URL]) async -> [UIImage] {
        return await withTaskGroup(of: UIImage?.self) { taskGroup in
            var images = [UIImage?]()
            
            for url in urls {
                taskGroup.addTask {
                    await loadImage(with: url)
                }
            }
            
            for await loadedImage in taskGroup {
                images.append(loadedImage)
            }
            
            return images.compactMap { $0 }
        }
    }
    
    private func loadImage(with url: URL) async -> UIImage? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}

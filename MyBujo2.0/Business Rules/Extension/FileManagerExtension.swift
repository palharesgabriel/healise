//
//  FileManagerExtension.swift
//  MyBujo2.0
//
//  Created by Adauto Pinheiro on 17/09/19.
//  Copyright © 2019 Gabriel Palhares. All rights reserved.
//

import Foundation

enum DirectoryType: String {
    case photo = "Photos"
    case video = "Video"
    case voiceRecord = "VoiceRecords"
}

extension FileManager {
    
    private var mainPath: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func createDirectory (day: Day, directoryOf type: DirectoryType) -> String {
        
		let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "yyyy-MM-dd"
        let date = dateFormmater.string(from: day.date!)
			
		let mainPath = self.urls(for: .documentDirectory, in: .userDomainMask).first!
        let path = mainPath.appendingPathComponent(date).appendingPathComponent("/" + type.rawValue)
           try? self.createDirectory(atPath: path.path, withIntermediateDirectories: true, attributes: nil)
		return "\(date)/\(type.rawValue)"
    }
    
    func directoryExists(path: String) -> Bool {
        var directory: ObjCBool = ObjCBool(false)
        return fileExists(atPath: path, isDirectory: &directory)
    }

    func saveFileTo(path filepath: URL, withData data: Data) -> Bool {
        do {
            try data.write(to: filepath)
        } catch {
            print(error)
        }
        return fileExists(atPath: filepath.path)
    }
    
    
    func sortPaths (paths: [String], mediaPath: String) -> [String] {
        var sortedPaths = paths
        sortedPaths.sort { (firstPath, secondPath) -> Bool in
            guard let firstDate = getCreatedDateFromFile(filename: firstPath, mediaPath: mediaPath) else { return false }
            guard let secondDate = getCreatedDateFromFile(filename: secondPath, mediaPath: mediaPath) else { return false }
            if firstDate > secondDate {
                return true
            }
            return false
        }
        return sortedPaths
    }
    
    func getCreatedDateFromFile (filename: String, mediaPath: String) -> Date? {
        do {
            let filePath = mainPath.appendingPathComponent(mediaPath).appendingPathComponent(filename)
            let attr = try FileManager.default.attributesOfItem(atPath: filePath.path)
            return attr[FileAttributeKey.creationDate] as? Date
        } catch {
            return nil
        }
    }
    
    func getPaths(for path: String) -> [String]? {
        do {
            let paths = try FileManager.default.contentsOfDirectory(atPath: self.mainPath.appendingPathComponent(path).path)
            return paths
        } catch {
            print(error)
            return nil
        }
    }
    
    func saveToFileManager<T: FileManagerInitiable>(media: T, mediaPath: String) {
        let path = mainPath.appendingPathComponent(mediaPath).appendingPathComponent(media.relativePathName)
        guard let data = media.dataRepresentation() else {  return }
        _ = FileManager.default.saveFileTo(path: path , withData: data)
    }

    /// Get your media type with generic
    func getMedia<T: FileManagerInitiable>(from relativePaths: [String], mediaPath: String) -> [T]? {
        let media: [T] = relativePaths.map { (path) -> T in
            let tempPath = self.mainPath.appendingPathComponent(mediaPath)
            let media = T(contentsOfFile: tempPath.appendingPathComponent(path).path)
            return media!
        }
        return media
    }
    
    func removePath(relativePath: String, mediaPath: String) {
        let pathToBeRemoved = mainPath.appendingPathComponent(mediaPath).appendingPathComponent(relativePath)
        do {
            try FileManager.default.removeItem(at: pathToBeRemoved)
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
}

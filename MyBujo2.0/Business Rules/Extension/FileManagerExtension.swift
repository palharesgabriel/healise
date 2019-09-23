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
    
    func createDirectory(day: Day, directoryOf type: DirectoryType) -> URL {
        let fileManager = FileManager.default
        let mainPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let path = mainPath.appendingPathComponent(day.date!.description).appendingPathComponent("/" + type.rawValue)
           try? fileManager.createDirectory(atPath: path.path, withIntermediateDirectories: true, attributes: nil)
           return path
       }
    
    func directoryExists(path: String) -> Bool {
        var directory: ObjCBool = ObjCBool(false)
        return fileExists(atPath: path, isDirectory: &directory)
    }

    func saveFileFrom(Path filepath: URL,WithData data: Data) -> Bool {
        do {
            try data.write(to: filepath)
        } catch {
            print(error)
        }
        return fileExists(atPath: filepath.path)
    }
}

//
//  AudioFileData.swift
//  iTunes Matcher
//
//  Created by Ian Taylor on 3/28/17.
//  Copyright © 2017 Ian Taylor. All rights reserved.
//

import Foundation
import ID3Edit

class AudioFileData {
    
    var url: URL
    var filename: String
    var searchQuery: String
    var importedFile: MP3File?
    var processed: Bool
    var title: String
    var artist: String
    var album: String
    var genre: String
    var year: String
    var trackNumber: Int?
    var artwork: NSImage?
    
    init(url: URL) {
        self.url = url
        
        self.filename = url.lastPathComponent
        self.searchQuery = removeFilePrefix(filename: url.deletingPathExtension().lastPathComponent)
        
        var mp3File: MP3File? =  nil
        do {
            mp3File = try MP3File(path: url.path)
        }
        catch ID3EditErrors.fileDoesNotExist
        {
            print("The file does not exist.")
        }
        catch ID3EditErrors.notAnMP3
        {
            print("The file you attempted to open was not an mp3 file.")
        }
        catch {}
        
        self.importedFile = mp3File
        self.processed = false
        self.title = ""
        self.artist = ""
        self.album = ""
        self.genre = ""
        self.year = ""
    }
    
    func writeId3TagsToFile()
    {
        if importedFile != nil {
            let file = importedFile!
            file.setTitle(title)
            file.setArtist(artist)
            file.setAlbum(album)
            try? file.writeTag()
            
            processed = true
        }
    }
}

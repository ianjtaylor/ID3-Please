//
//  AppDelegate.swift
//  iTunes Matcher
//
//  Created by Ian Taylor on 3/12/17.
//  Copyright © 2017 Ian Taylor. All rights reserved.
//

import Cocoa
import ID3Edit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        //var file: MP3File? = nil
        //
        //        do {
        //        //file = try MP3File(path: "/Users/ianjtaylor/Downloads/file.mp3")
        //            let mp3File = try MP3File(path: "/Users/ianjtaylor/Downloads/file.mp3")
        //            // Use MP3File(data: data) data being an NSData object
        //            // to load an MP3 file from memory
        //            // NOTE: If you use the MP3File(data: NSData?) initializer make
        //            //       sure to set the path before calling writeTag() or an
        //            //       exception will be thrown
        //
        //            // Get song information
        //            print("Title:\t\(mp3File.getTitle())")
        //            print("Artist:\t\(mp3File.getArtist())")
        //            print("Album:\t\(mp3File.getAlbum())")
        //            print("Lyrics:\n\(mp3File.getLyrics())")
        ////            mp3File.setTitle("The new song title")
        ////            mp3File.setArtist("The new artist")
        ////            mp3File.setAlbum("The new album")
        ////            mp3File.setLyrics("Yeah Yeah new lyrics")
        //
        //            //try mp3File.writeTag()
        //
        //        }
        //        catch ID3EditErrors.fileDoesNotExist
        //        {
        //            print("The file does not exist.")
        //        }
        //        catch ID3EditErrors.notAnMP3
        //        {
        //            print("The file you attempted to open was not an mp3 file.")
        //        }
        //        catch {}
        //
        ////        if(file != nil){
        ////            let artist = getArtistFromMp3(file: file!)
        ////          print("Artist: \(artist)")
        ////        }
        //
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
}


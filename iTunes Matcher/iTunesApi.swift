//
//  iTunesApi.swift
//  iTunes Matcher
//
//  Created by Ian Taylor on 3/12/17.
//  Copyright © 2017 Ian Taylor. All rights reserved.
//

import Foundation
import ID3Edit

// TODO: need to fix get() ID3 methods before this can be done
func getArtistFromMp3(file: MP3File) -> String {
    let artist = file.getArtist();
        return artist
}

func getSearchFromFilename(filename: String) -> String {
    return ""
}

//
//  ViewController.swift
//  iTunes Matcher
//
//  Created by Ian Taylor on 3/12/17.
//  Copyright © 2017 Ian Taylor. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet var drag: DraggingDestinationView!
    
    var files: [AudioFileData] = []
    var selectedRow: Int = -1
    
    @IBOutlet weak var searchField: NSTextField!
    @IBOutlet weak var fileList: NSTableColumn!
    
    @IBOutlet weak var artistLabel: NSTextField!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var albumLabel: NSTextField!
    @IBOutlet weak var genreLabel: NSTextField!
    @IBOutlet weak var yearLabel: NSTextField!
    @IBOutlet weak var trackLabel: NSTextField!
    @IBOutlet weak var albumArtwork: NSImageView!
    
    @IBAction func writeTags(_ sender: Any) {
        let file = files[selectedRow]
        file.writeId3TagsToFile()
        tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drag.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        searchField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func setTitleLabel(label: String) {
        titleLabel.stringValue = label
    }
    func setArtistLabel(label: String) {
        artistLabel.stringValue = label
    }
    func setAlbumLabel(label: String) {
        albumLabel.stringValue = label
    }
    func setGenreLabel(label: String) {
        genreLabel.stringValue = label
    }
    func setYearLabel(label: String) {
        yearLabel.stringValue = String(label)
    }
    func setTrackLabel(label: Int) {
        trackLabel.stringValue = String(label)
    }
    func setArtwork(artwork: NSImage) {
        albumArtwork.image = artwork
    }
    
    
    func makeApiRequestToItunes(searchQuery: String, index: Int) {
        let urlString = "https://itunes.apple.com/search?term=\(searchQuery)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) -> Void in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            print(json)
            
            let resultCount = json["resultCount"] as! Int
            
            if resultCount > 0 {
                
                var results = json["results"] as! [Any]
                var thisResult = results[0] as! [String: Any]
                
                let title = thisResult["trackName"] as! String
                let artist = thisResult["artistName"] as! String
                let album = thisResult["collectionName"] as! String
                let genre = thisResult["primaryGenreName"] as! String
                let trackNumber = thisResult["trackNumber"] as! Int
                let releaseDate = thisResult["releaseDate"]! as! String
                var artworkUrlString = thisResult["artworkUrl100"] as! String
                
                self.files[index].title = title
                self.files[index].artist = artist
                self.files[index].album = album
                self.files[index].genre = genre
                self.files[index].trackNumber = trackNumber
                
                let stringIndex = releaseDate.index(releaseDate.startIndex, offsetBy: 4)
                
                let year = releaseDate.substring(to: stringIndex)
                self.files[index].year = year
                
                artworkUrlString = artworkUrlString.replacingOccurrences(of: "100x100bb", with: "2000x2000bb")
                let artworkUrl = URL(fileURLWithPath: artworkUrlString)
                
                DispatchQueue.main.async() {
                    self.setTitleLabel(label: title)
                    self.setArtistLabel(label: artist)
                    self.setAlbumLabel(label: album)
                    self.setGenreLabel(label: genre)
                    self.setTrackLabel(label: trackNumber)
                    self.setYearLabel(label: year)
                    //                self.setArtwork(artwork: artwork!)
                }
            }
            else {
                DispatchQueue.main.async() {
                    self.setTitleLabel(label: "No Results Found")
                }
            }
            
        }
        task.resume()
    }
    
}

extension ViewController: NSTableViewDelegate, NSTableViewDataSource, DraggingDestinationViewDelegate, NSTextFieldDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        let fileCount = files.count
        return fileCount
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if files.count == 0 {
            return nil
        }
        
        let item = (files)[row]
        let identifier = tableColumn?.identifier
        
        if let cell = tableView.make(withIdentifier: identifier!, owner: nil) as? NSTableCellView {
            var text: String = ""
            
            if (identifier == "filename") {
                text = item.filename
            }
            else if (identifier == "processed") {
                text = item.processed.description
            }
            
            cell.textField?.stringValue = text
            
            return cell
        }
        return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        if tableView.selectedRow >= 0 {
            let file = files[tableView.selectedRow]
            searchField.stringValue = file.searchQuery
            let json = makeApiRequestToItunes(searchQuery: file.searchQuery, index: tableView.selectedRow)
            selectedRow = tableView.selectedRow
        }
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        let json = makeApiRequestToItunes(searchQuery: searchField.stringValue, index: selectedRow)
    }
    
    func processFileURLs(_ urls: [URL], center: NSPoint) {
        
        for (_, url) in urls.enumerated() {
            let thisFile = AudioFileData(url: url)
            files.append(thisFile)
            print("got file \(thisFile.filename)")
        }
        tableView.reloadData()
    }
    
    func processArtwork(_ image: NSImage, center: NSPoint) {
        
        //            let constrainedSize = image.aspectFitSizeForMaxDimension(Appearance.maxStickerDimension)
        //
        //            let subView = NSImageView(frame: NSRect(x: center.x - constrainedSize.width/2, y: center.y - constrainedSize.height/2, width: constrainedSize.width, height: constrainedSize.height))
        //            subView.image = image
        //            targetLayer.addSubview(subView)
        //
        //            let maxRotation = CGFloat(arc4random_uniform(Appearance.maxRotation)) - Appearance.rotationOffset
        //            subView.frameCenterRotation = maxRotation
    }
    
    func processAction(_ action: String, center: NSPoint) {
    }
    
}


//
//  ViewController.swift
//  iTunes Matcher
//
//  Created by Ian Taylor on 3/12/17.
//  Copyright © 2017 Ian Taylor. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {

    @IBOutlet var drag: DraggingDestinationView!
    @IBOutlet weak var fileTable: NSTableView!
    @IBOutlet weak var fileList: NSTableColumn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drag.delegate = self

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    
}
    extension ViewController : DraggingDestinationViewDelegate {
        
        func processImageURLs(_ urls: [URL], center: NSPoint) {
            
            for (index, url) in urls.enumerated() {
                print(url.absoluteString)
            }
        }
        
        func processImage(_ image: NSImage, center: NSPoint) {
            
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


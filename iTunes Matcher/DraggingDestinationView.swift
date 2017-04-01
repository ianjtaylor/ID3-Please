import Cocoa
import AVFoundation


protocol DraggingDestinationViewDelegate {
    func processFileURLs(_ urls: [URL], center: NSPoint)
    func processArtwork(_ image: NSImage, center: NSPoint)
}

class DraggingDestinationView: NSView {
    
    enum Appearance {
        static let lineWidth: CGFloat = 10.0
    }
    
    var delegate: DraggingDestinationViewDelegate?
    
    override func awakeFromNib() {
        setup()
    }
    
    var acceptableTypes: Set<String> { return [NSURLPboardType] }
    
    func setup() {
        register(forDraggedTypes: Array(acceptableTypes))
    }
    
    override func draw(_ dirtyRect: NSRect) {
        if isReceivingDrag {
            NSColor.selectedControlColor.set()
            
            let path = NSBezierPath(rect:bounds)
            path.lineWidth = Appearance.lineWidth
            path.stroke()
        }
    }
    
    
    let musicFilteringOptions = [NSPasteboardURLReadingContentsConformToTypesKey: [AVFoundation.AVFileTypeMPEGLayer3]]
    
    func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool {
        var canAccept = false
        
        let pasteBoard = draggingInfo.draggingPasteboard()
        
        if pasteBoard.canReadObject(forClasses: [NSURL.self], options: musicFilteringOptions) {
            canAccept = true
        }
        
        return canAccept
    }
    
    var isReceivingDrag = false {
        didSet {
            needsDisplay = true
        }
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let allow = shouldAllowDrag(sender)
        
        isReceivingDrag = allow
        
        return allow ? .copy : NSDragOperation()
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        isReceivingDrag = false
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let allow = shouldAllowDrag(sender)
        return allow
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        
        isReceivingDrag = false
        let pasteBoard = sender.draggingPasteboard()
        
        let point = convert(sender.draggingLocation(), from: nil)
        
        if let urls = pasteBoard.readObjects(forClasses: [NSURL.self], options: musicFilteringOptions) as? [URL], urls.count > 0 {
            delegate?.processFileURLs(urls, center: point)
            return true
        }
        
        return false
    }
    
    
}

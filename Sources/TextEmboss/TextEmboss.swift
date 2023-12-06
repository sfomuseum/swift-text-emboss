import Foundation
import Vision

public struct ProcessImageResult: Encodable {
    public var text: String
    public var source: String
    public var created: Int
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)
public struct TextEmboss {

    let req = VNRecognizeTextRequest()
    
    public init() {
    }
    
    public func ProcessImage(image: CGImage) -> Result<ProcessImageResult, Error> {
                
        let handler = VNImageRequestHandler(cgImage: image, options: [:])

        do {
            try handler.perform([req])
        } catch {
            return .failure(error)
        }
        
        var transcript = ""

        if req.results != nil {
            
            let maximumCandidates = 1
            for observation in req.results! {
                guard let candidate = observation.topCandidates(maximumCandidates).first else { continue }
                transcript += candidate.string
                transcript += "\n"
            }
        }

        transcript = transcript.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let proc = ProcessInfo()
        
        let source = String(format:"com.apple.visionkit.VNImageRequestHandler#%@", proc.operatingSystemVersionString)
        let created = Int(Date().timeIntervalSince1970)
        
        let rsp = ProcessImageResult(
            text: transcript,
            source: source,
            created: created
        )
        
        return .success(rsp)
    }
}

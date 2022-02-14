import Foundation
import Vision

@available(macOS 10.15, *)
public struct TextEmboss {

    let req = VNRecognizeTextRequest()
    
    public init() {
    }
    
    public func ProcessImage(image: CGImage) -> Result<String, Error> {
                
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
        return .success(transcript)
    }
}

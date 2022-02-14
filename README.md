# swift-text-emboss

An opinionated Swift package for basic `VNRecognizeTextRequest` operations.

## Documentation

Documentation is incomplete at this time.

## Example

```
let te = TextEmboss()
let rsp = te.ProcessImage(image: cgImage)
```

As in:

```
import TextEmboss
import Foundation
import AppKit

public enum Errors: Error {
    case notFound
    case invalidImage
    case cgImage
}

let fm = FileManager.default

if (!fm.fileExists(atPath: inputFile)){
    throw(Errors.notFound)
}

guard let im = NSImage(byReferencingFile:inputFile) else {
    throw(Errors.invalidImage)
}

guard let cgImage = im.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
    throw(Errors.cgImage)
}

let te = TextEmboss()
let rsp = te.ProcessImage(image: cgImage)

switch rsp {
case .failure(let error):
    throw(error)
case .success(let txt):
    print(txt)
}
```

## See also

* https://developer.apple.com/documentation/vision

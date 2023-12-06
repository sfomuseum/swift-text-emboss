# swift-text-emboss

An opinionated Swift package for basic `VNRecognizeTextRequest` operations.

## Background

For background, please see the [Searching Text in Images on the Aviation Collection Website](https://millsfield.sfomuseum.org/blog/2023/09/14/image-text-search/) blog post.

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
case .success(let rsp):
    print(rsp.text)
}
```

### Results

Where `rsp` is a `ProcessImageResult` instance:

```
public struct ProcessImageResult: Encodable {
    public var text: String
    public var source: String
    public var created: Int64
}
```

Note: The `source` key is an arbitrary string used to identify the processes, or models, from which image text was derived. As of this writing this string has no standard formatting or requirements. If and when those conventions are established this package will be updated to use them.

For example (using the `text-emboss` tool in the [sfomuseum/swift-text-emboss-cli](https://github.com/sfomuseum/swift-image-emboss-cli) package)

```
$> ./.build/debug/text-emboss --as-json true /usr/local/test.png | jq
{
  "text": "1666533115581165568-wayfinding-from-1847571933-t…\nPage 9 of 179\nQr Search\n166653311558116…\n#2, 3, 5, 7, from Nine Drypoints and Etchings\n9\n7%\n10\n11\nhttps://www.sfomuseum.org/public-art/public-collection/2-3-5-7-nine-drypoints-and-etchings\nSFO Museum Galleries and exhibitions from SFO Museum and public art works from the San Francisco Art Commission that you'll encounter\nbetween Grand Hyatt Hotel Lobby and Gate B18 at SFO in June, 2023.",
  "created": 1701890454,
  "source": "com.apple.visionkit.VNImageRequestHandler#Version 14.1.2 (Build 23B92)"
}
``` 

## See also

* https://github.com/sfomuseum/swift-text-emboss-cli
* https://github.com/sfomuseum/swift-text-emboss-www
* https://github.com/sfomuseum/swift-text-emboss-grpc
* https://github.com/sfomuseum/go-text-emboss
* https://developer.apple.com/documentation/vision

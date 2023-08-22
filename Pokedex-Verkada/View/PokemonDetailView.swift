//import SwiftUI
//import UIKit
//struct AsyncImage: View {
//    @State private var image: UIImage? = nil
//    let url: String?
//    
//    var body: some View {
//        Group {
//            if let image = image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//            } else {
//                ProgressView()
//            }
//        }
//        .onAppear(perform: loadImage)
//    }
//
//    func loadImage() {
//        image = nil
//        guard let urlString = url, let imageURL = URL(string: urlString) else { return }
//
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: imageURL) {
//                DispatchQueue.main.async {
//                    self.image = UIImage(data: data)
//                }
//            }
//        }
//    }
//}
//
//

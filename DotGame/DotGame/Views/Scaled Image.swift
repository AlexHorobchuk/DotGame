//
//  Scaled Image.swift
//  DotGame
//
//  Created by Olha Dzhyhirei on 6/8/23.
//

import SwiftUI

struct ScaledImage: View {
    
    let name: String
    let size: CGSize
    
    var body: some View {
        let uiImage = resizedImage(named: self.name, for: self.size) ?? UIImage()
        
        return Group {
            Image(uiImage: uiImage.withRenderingMode(.alwaysOriginal))
        }
    }
    
    func resizedImage(named: String, for size: CGSize) -> UIImage? {
        guard let image = UIImage(systemName: named) else {
            return nil
        }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        let renderedImage = renderer.image { context in
            UIColor.clear.setFill()
            context.fill(CGRect(origin: .zero, size: size))
            
            let imageRect = CGRect(origin: .zero, size: size)
            image.withTintColor(.gray, renderingMode: .alwaysOriginal).draw(in: imageRect)
        }
        
        return renderedImage
    }
}

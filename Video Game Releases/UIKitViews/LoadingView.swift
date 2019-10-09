//
//  LoadingView.swift
//  SwiftUI-GameDB
//
//  Created by George on 08/10/2019.
//  Copyright © 2019 George. All rights reserved.
//

import SwiftUI

struct LoadingView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<LoadingView>) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        return activityIndicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<LoadingView>) {
        uiView.startAnimating()
    }
}


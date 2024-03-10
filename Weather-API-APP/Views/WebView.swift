//
//  WebView.swift
//  Weather-API-APP
//
//  Created by Fadhli Firdaus on 10/03/2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL?
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

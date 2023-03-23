//
//  WebviewView.swift
//  sluv-ios-renew
//
//  Created by JunYong Park on 2023/03/23.
//

import SwiftUI
import WebKit

struct WebviewView: View {
    @State private var showWebView = false
    private let urlString: String = "https://sluv.co.kr/"
     
    var body: some View {
        WebView(url: URL(string: urlString)!)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
        webView.scrollView.minimumZoomScale = 1.0
        webView.scrollView.maximumZoomScale = 1.0
        webView.scrollView.bounces = false
        webView.allowsBackForwardNavigationGestures = true
        if #available(iOS 10.0, *) {
            webView.scrollView.refreshControl = nil
        } else {
            for subview in webView.scrollView.subviews {
                if let refreshControl = subview as? UIRefreshControl {
                    refreshControl.removeFromSuperview()
                }
            }
        }
    }
}
struct WebviewView_Previews: PreviewProvider {
    static var previews: some View {
        WebviewView()
    }
}

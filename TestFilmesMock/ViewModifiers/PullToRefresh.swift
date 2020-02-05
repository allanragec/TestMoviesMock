//
//  PullToRefresh.swift
//  TestFilmesMock
//
//  Created by Allan Melo on 03/02/20.
//  Copyright © 2020 Allan Melo. All rights reserved.
//

import UIKit
import Combine
import SwiftUI

struct PullToRefreshModifier: ViewModifier {
    var onRefresh: () -> ()
 
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            PullToRefreshView(width: geometry.size.width,
                             height: geometry.size.height,
                             listView: content.typeErased,
                             onRefresh: self.onRefresh)
        }
    }
}

struct PullToRefreshView : UIViewRepresentable {
    private static var current: UIRefreshControl?
    
    var width : CGFloat
    var height : CGFloat
    let listView: AnyView
    var onRefresh: () -> ()
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    static func endRefreshing() { current?.endRefreshing() }
    
    func makeUIView(context: Context) -> UIScrollView {
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        PullToRefreshView.current = control.refreshControl
        control
            .refreshControl?
            .addTarget(context.coordinator,
                       action: #selector(Coordinator.handleRefreshControl), for: .valueChanged)
        let childView = UIHostingController(rootView: listView)
        childView.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        control.addSubview(childView.view)
        return control
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        PullToRefreshView.current = uiView.refreshControl
        context.coordinator.onRefresh = {
            self.onRefresh()
        }
    }
    
    class Coordinator: NSObject {
        var onRefresh: () -> () = {}
        
        @objc func handleRefreshControl(sender: UIRefreshControl) {
            self.onRefresh()
        }
    }
}

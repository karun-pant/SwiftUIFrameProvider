//
//  File.swift
//  SwiftUIFrameProvider
//
//  Created by Karun Pant on 19/02/23.
//


import SwiftUI

/// This will give frame of a view based on it's parent coordinate space
/// if it's named as passed in `coordinateSpaceID` else it will track global cordinate space.
struct CoordinateSpaceFrameProvider: ViewModifier {
    var shouldIgnore: Bool
    ///  global -> framse as per global view
    ///  local -> bounds
    ///  named -> you own named space.
    var coordinateSpace: CoordinateSpace
    let frame: (_ frame: CGRect) -> Void
    
    @ViewBuilder func body(content: Content) -> some View {
        if shouldIgnore {
            content
        } else {
            content
                .background(GeometryReader(content: { contentProxy in
                    Color.clear.onAppear {
                        frame(contentProxy.frame(in: coordinateSpace))
                    }
                }))
        }
        
    }
}

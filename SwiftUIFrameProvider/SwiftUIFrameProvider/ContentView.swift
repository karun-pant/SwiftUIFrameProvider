//
//  ContentView.swift
//  SwiftUIFrameProvider
//
//  Created by Karun Pant on 19/02/23.
//

import SwiftUI

struct ContentView: View {
    let coordinateSpaceID = "scroll"
    let viewIndexForThreshold: Int
        let bgColor = [Color.indigo, Color.mint]
        @State private var bounds: CGRect = .zero
        @State private var globalFrame: CGRect = .zero
        @State private var frameInScrollView: CGRect = .zero
    @State private var showFrameMessage: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Stickey Header")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .padding()
                Spacer()
            }
            .frame(height: 100)
            .background(Color.gray)
            ScrollView {
                VStack (alignment: .leading) {
                    ForEach(0..<30) { i in
                        Button {
                            showFrameMessage = true
                        } label: {
                            HStack {
                                Text("Item \(i + 1)")
                                    .foregroundColor(.black)
                                    .padding()
                                Spacer()
                            }
                            .frame(height: 100)
                            .background(bgColor[ i % 2 ])
                        }
                        // bounds
                        .modifier(CoordinateSpaceFrameProvider(
                            shouldIgnore: viewIndexForThreshold != i,
                            coordinateSpace: .local,
                            frame: { frame in
                                print("Index: \(i) rect: \(frame)")
                                bounds = frame
                            }))
                        // Global frame
                        .modifier(CoordinateSpaceFrameProvider(
                            shouldIgnore: viewIndexForThreshold != i,
                            coordinateSpace: .global,
                            frame: { frame in
                                print("Index: \(i) rect: \(frame)")
                                globalFrame = frame
                            }))
                        // frameInScrollView
                        .modifier(CoordinateSpaceFrameProvider(
                            shouldIgnore: viewIndexForThreshold != i,
                            coordinateSpace: .named(coordinateSpaceID),
                            frame: { frame in
                                print("Index: \(i) rect: \(frame)")
                                frameInScrollView = frame
                            }))
                        .alert(message,
                               isPresented: $showFrameMessage,
                               actions: {
                            Button("OK", role: .cancel) { }
                        })
                    }
                }
            }
        }
    }
    
    private var message: String {
        let frameMessage = "Global View:\n\(globalFrame) \n\nView Bounds:\n\(bounds) \n\nFrame in Perspective to Scroll View or named Coordinate space:\n\(frameInScrollView)"
        return "Tacking View number \(viewIndexForThreshold).\n\n Frame for View number \(viewIndexForThreshold) is:\n\n\(frameMessage)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewIndexForThreshold: 25)
    }
}

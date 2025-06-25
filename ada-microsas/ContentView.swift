//
//  ContentView.swift
//  ada-microsas
//
//  Created by Giovanni Galarda Strasser on 25/06/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TimerTestView()
            .environmentObject(TimerViewModel())
    }
}

#Preview {
    ContentView()
}

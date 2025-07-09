//
//  will.swift
//  ada-microsas
//
//  Created by Giovanni Galarda Strasser on 09/07/25.
//
import SwiftUI

final class Router: ObservableObject {
    @Published var path = NavigationPath()

    func popToRoot() {
        path = NavigationPath()
    }
}

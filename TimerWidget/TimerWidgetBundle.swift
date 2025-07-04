//
//  TimerWidgetBundle.swift
//  TimerWidget
//
//  Created by Giovanni Galarda Strasser on 04/07/25.
//

import WidgetKit
import SwiftUI

@main
struct TimerWidgetBundle: WidgetBundle {
    var body: some Widget {
        TimerWidget()
        TimerWidgetControl()
        TimerWidgetLiveActivity()
    }
}

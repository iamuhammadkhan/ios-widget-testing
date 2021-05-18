//
//  PrayerWidget.swift
//  PrayerWidget
//
//  Created by Muhammad Khan on 5/11/21.
//

import WidgetKit
import SwiftUI
import Adhan

struct PrayerWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family
   
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            PWSmallView(prayer: entry)
        case .systemMedium:
            PWMediumView(prayer: entry)
        default:
            fatalError()
        }
    }
}

@main
struct PrayerWidget: Widget {
    let kind: String = "PrayerWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PrayerWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct PrayerWidget_Previews: PreviewProvider {
    static var previews: some View {
        PrayerWidgetEntryView(entry: PrayerEntry.mockPrayerEntry())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

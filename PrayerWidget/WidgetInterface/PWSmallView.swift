//
//  PWSmallView.swift
//  PrayerWidgetExtension
//
//  Created by Muhammad Khan on 5/11/21.
//

import SwiftUI
import WidgetKit

struct PWSmallView: View {
    
    private var prayer: PrayerEntry
    
    init(prayer: PrayerEntry) {
        self.prayer = prayer
    }
        
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Image("\(prayer.nextPrayerImage)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .bottom)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text("\(prayer.currentPrayerName)".capitalized + " Time")
                    .font(.subheadline.bold())
                    .foregroundColor(.white)
                Text("\(prayer.currentPrayerTime)")
                    .font(.headline.bold())
                    .foregroundColor(.orange)
                    .padding(.bottom, 20)
                Text("\(prayer.untilNextPrayerTime)")
                    .font(.footnote.bold())
                    .foregroundColor(.white)
                Text("Until pray time")
                    .font(.caption.bold())
                    .foregroundColor(.white)
            }
        }
    }
}

struct PWSmallView_Previews: PreviewProvider {
    static var previews: some View {
        PWSmallView(prayer: PrayerEntry.mockPrayerEntry())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


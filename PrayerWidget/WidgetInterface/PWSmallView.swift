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
                    .frame(width: geo.size.width + 4, height: geo.size.height + 4, alignment: .bottom)
                    .offset(x: -2, y: -2)
            }
            GeometryReader { geo in
                Image(Constants.moonImageIconName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 16, height: 16, alignment: .center)
                    .offset(x: geo.size.width - 32, y: 16)
            }
            GeometryReader { geo in
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(prayer.currentPrayerName)".capitalized)
                        .font(.system(size: 18, weight: .semibold, design: .default))
                        .foregroundColor(prayer.primaryTextColor)
                        .padding(.bottom, 4)
                    Text("\(prayer.currentPrayerTime)")
                        .font(.system(size: 22, weight: .heavy, design: .default))
                        .foregroundColor(prayer.highlightedTextColor)
                        .padding(.bottom, geo.size.height / 4)
                    Text("\(prayer.untilNextPrayerTime) \(Constants.prayerTimeRemainingText)")
                        .font(.system(size: 15, weight: .medium, design: .default))
                        .foregroundColor(prayer.primaryTextColor)
                }.frame(width: geo.size.width - 32, height: geo.size.height - 32, alignment: .topLeading)
                .offset(x: 16, y: 25)
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


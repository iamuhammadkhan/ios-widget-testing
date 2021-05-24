//
//  PWMediumView.swift
//  PrayerWidgetExtension
//
//  Created by Muhammad Khan on 5/11/21.
//

import SwiftUI
import WidgetKit

struct PWMediumView: View {
    
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
                    HStack(alignment: .bottom, spacing: 8) {
                        Text("\(prayer.currentPrayerTime)")
                            .font(.system(size: 22, weight: .heavy, design: .default))
                            .foregroundColor(prayer.highlightedTextColor)
                        Text("\(prayer.untilNextPrayerTime) \(Constants.prayerTimeRemainingText)")
                            .font(.system(size: 15, weight: .medium, design: .default))
                            .foregroundColor(prayer.primaryTextColor)
                            .padding(.bottom, 3)
                    }
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        PrayerTimeView(prayer: prayer.prayers[0])
                        PrayerTimeView(prayer: prayer.prayers[1])
                        PrayerTimeView(prayer: prayer.prayers[2])
                        PrayerTimeView(prayer: prayer.prayers[3])
                    }.padding(.bottom, 12).padding(.top, 12)
                }.frame(width: geo.size.width - 32, height: geo.size.height - 32, alignment: .topLeading)
                .offset(x: 16, y: 25)
            }
        }
    }
}

struct PWMediumView_Previews: PreviewProvider {
    static var previews: some View {
        PWMediumView(prayer: PrayerEntry.mockPrayerEntry())
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

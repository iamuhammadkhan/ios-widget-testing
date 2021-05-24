//
//  PrayerTimeView.swift
//  PrayerWidgetExtension
//
//  Created by Muhammad Khan on 5/20/21.
//

import SwiftUI

struct PrayerTimeView: View {
    var prayer: MyPrayer
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Rectangle()
                    .foregroundColor(.white)
                    .opacity(0.2)
                    .cornerRadius(8)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                VStack(alignment: .leading, spacing: 4) {
                    Text(prayer.prayerName.capitalized)
                        .foregroundColor(prayer.textColor)
                        .font(.system(size: 12, weight: .medium, design: .default))
                    Text(prayer.prayerTime)
                        .foregroundColor(prayer.textColor)
                        .font(.system(size: 11, weight: .medium, design: .default))
                        .opacity(0.6)
                }.frame(width: geo.size.width - 16, height: geo.size.height - 16, alignment: .leading)
                .offset(x: 8, y: 8)
            }
        }
    }
}

struct PrayerTimeView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerTimeView(prayer: MyPrayer(prayerName: "Isha", prayerTime: "20:25", textColor: .white))
    }
}

//
//  WorldTime.swift
//  TableViewStudy
//
//  Created by 김정민 on 2020/02/22.
//  Copyright © 2020 kjm. All rights reserved.
//

import Foundation

struct WorldTime {
   let date: String
   let hoursFromGMT: Int
   let location: String
   let time: String
   
   static func generateData() -> [WorldTime] {
      let list = [("Asia/Seoul", "Seoul"), ("America/New_York", "New York"), ("Europe/Paris", "Paris"), ("Europe/London", "London"), ("Europe/Zurich", "Zurich")]
      
      let now = Date()
      let formatter = DateFormatter()
      //formatter.locale = Locale(identifier: "Ko_kr")
      formatter.doesRelativeDateFormatting = true
      
      var result = [WorldTime]()
      
      for (timeZone, location) in list {
         guard let tz = TimeZone(identifier: timeZone) else { continue }
         
         let dt = now.addingTimeInterval(TimeInterval(tz.secondsFromGMT() - (9 * 3600)))
         
         formatter.dateStyle = .short
         formatter.timeStyle = .none
         let date = formatter.string(from: dt)
         
         formatter.dateStyle = .none
         formatter.timeStyle = .short
         let time = formatter.string(from: dt)
         let hoursFromGMT = (tz.secondsFromGMT() / 3600) - 9
         
         let data = WorldTime(date: date, hoursFromGMT: hoursFromGMT, location: location, time: time)
         result.append(data)
      }
      
      return result
   }
}

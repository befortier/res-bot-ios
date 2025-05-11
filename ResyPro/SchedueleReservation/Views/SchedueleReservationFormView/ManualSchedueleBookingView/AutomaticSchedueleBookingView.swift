//
//  AutomaticSchedueleBookingView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/27/24.
//

import Foundation
import SwiftUI
import DesignSystem
import Venues

struct AutomaticSchedueleBookingView: View {
    @StateObject var viewModel: ViewModel
    var confirmed: () -> Void

    init(
        viewModel: @autoclosure @escaping () -> ViewModel,
        confirmed: @escaping () -> Void
    ) {
        self._viewModel = StateObject(wrappedValue: viewModel())
        self.confirmed = confirmed
    }

    var body: some View {
        Text(viewModel.bookingDateText)
            .font(.subheadline)
            .foregroundStyle(.textSecondary)

        self.reservationDateView
    }

    @ViewBuilder
    private var reservationDateView: some View {
        VStack(spacing: 20) {
            Text("What times would you like to eat?")
                .font(.callout)
                .foregroundColor(.textPrimary)

            SelectDateRangeView(
                selectedDateRange: $viewModel.reservationDate
            )
                .datePickerStyle(.compact)


            Button("Confirm") {
                viewModel.calculateQueuedDate()
                self.confirmed()
            }
            .buttonStyle(PrimaryButtonStyle())
        }
    }
}

extension AutomaticSchedueleBookingView {
    @MainActor
    final class ViewModel: ObservableObject {
        @Binding var reservationDateBinding: DateInterval
        @Binding var queuedDateBinding: Date

        @Published var reservationDate: DateInterval
        let bookingInfo: BookingInfoDTO

        let bookingDateText: String

        init(
            reservationDate: Binding<DateInterval>,
            queuedDate: Binding<Date>,
            bookingInfo: BookingInfoDTO
        ) {

            self._queuedDateBinding = queuedDate
            self._reservationDateBinding = reservationDate
            self.bookingInfo = bookingInfo

            self.bookingDateText = if let dateText = Self.convertTimeToLocal(from: bookingInfo.time) {
                "Reservations are released \(bookingInfo.daysOut) days out at \(dateText) EST"
            } else { "Contact Support "}

            self.reservationDate = if let dateInterval = Self.dateInterval(fromDaysAhead: bookingInfo.daysOut) {
                dateInterval
            } else {
                reservationDate.wrappedValue
            }
        }

        func calculateQueuedDate() {
            self.reservationDateBinding = reservationDate

            self.queuedDateBinding = dateWithTime(
                from: reservationDate.start,
                daysBefore: bookingInfo.daysOut,
                time: bookingInfo.time
            ) ?? .now
            
            print(queuedDateBinding, reservationDateBinding)
        }

        static func convertTimeToLocal(from utcTime: String) -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")

            guard let utcDate = dateFormatter.date(from: utcTime) else {
                return nil
            }

            dateFormatter.dateFormat = "h:mm a"
            dateFormatter.timeZone = TimeZone.current
            let localTime = dateFormatter.string(from: utcDate)

            return localTime
        }

        static func dateInterval(fromDaysAhead days: Int) -> DateInterval? {
            let calendar = Calendar.current
            let now = Date()

            // Calculate the target date which is N days ahead
            guard let targetDate = calendar.date(byAdding: .day, value: days, to: now) else {
                return nil
            }

            // Create the start date at 7:00 PM on the target date
            var startComponents = calendar.dateComponents([.year, .month, .day], from: targetDate)
            startComponents.hour = 19
            startComponents.minute = 0

            guard let startDate = calendar.date(from: startComponents) else {
                return nil
            }

            // Create the end date at 9:00 PM on the target date
            var endComponents = calendar.dateComponents([.year, .month, .day], from: targetDate)
            endComponents.hour = 21
            endComponents.minute = 0

            guard let endDate = calendar.date(from: endComponents) else {
                return nil
            }

            return DateInterval(start: startDate, end: endDate)
        }

        func dateWithTime(from date: Date, daysBefore: Int, time: String) -> Date? {
            let calendar = Calendar.current

            // Subtract the specified number of days from the given date
            guard let targetDate = calendar.date(byAdding: .day, value: -daysBefore, to: date) else {
                return nil
            }

            // Parse the time string in "HH:mm" format
            let timeComponents = time.split(separator: ":")
            guard timeComponents.count == 2,
                  let hour = Int(timeComponents[0]),
                  let minute = Int(timeComponents[1]) else {
                return nil
            }

            // Create date components with the target date's year, month, and day, and the specified hour and minute
            var dateComponents = calendar.dateComponents([.year, .month, .day], from: targetDate)
            dateComponents.hour = hour
            dateComponents.minute = minute
            dateComponents.timeZone = .gmt

            // Create the new date with the combined components
            return calendar.date(from: dateComponents)
        }

    }
}

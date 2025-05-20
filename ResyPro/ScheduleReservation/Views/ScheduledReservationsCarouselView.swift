//
//  ScheduledReservationsCarouselView.swift
//  ResyPro
//
//  Created by Ben Fortier on 6/19/24.
//

import Foundation
import SwiftUI
import SwiftData
import DesignSystem

	struct ScheduledReservationsCarouselView: View {
	@Query private var scheduledReservations: [ScheduledReservation]
	
	    var body: some View {
	        ScrollView(.horizontal) {
	            HStack(spacing: 8) {
	                ForEach(scheduledReservations) { scheduledReservation in
	                    ScheduledReservationsCarouselCard(scheduledReservation: scheduledReservation)
	                }
	            }
	        }
	    }
	}
	
	struct ScheduledReservationsCarouselCard: View {
	let scheduledReservation: ScheduledReservation
	
	    var body: some View {
	        VStack(spacing: 4) {
	            Text(scheduledReservation.venue.name)
	                .font(.design(.headline))
	                .foregroundStyle(.primary)
	
	            Text(scheduledReservation.acceptedDateInterval, formatter: DateIntervalFormatter.short)
	                .font(.design(.subheadline))
	                .foregroundStyle(.secondary)
	        }
	        .padding()
	        .background(Color.gray.opacity(0.4))
	        .clipShape(RoundedRectangle(cornerRadius: 4))
	    }
	}

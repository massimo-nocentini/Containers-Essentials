Extension { #name : #DateAndTime }

{ #category : #'*Containers-Essentials-Visualizations' }
DateAndTime >> asISO8601String [

	^ self asString
]

{ #category : #'*Containers-Essentials-Visualizations' }
DateAndTime >> asTimeString [

	^ self asTime asString
]

{ #category : #'*Containers-Essentials-Visualizations' }
DateAndTime >> asTimeZoneString [

	^ self timeZone abbreviation
]

{ #category : #'*Containers-Essentials-Visualizations' }
DateAndTime >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection , { 
		  (#asTimeZoneString asSlotDescriptor inline: true).
		  #asISO8601String asSlotDescriptor.
		  (#asLocalStringYMDHM asSlotDescriptor inline: true).
		  #dayOfWeekName.
		  #monthName.
		  #month.
		  #dayOfMonth.
		  "		  ('Day of year' -> [ :anObj | anObj dayOfYear ])."
		  #year.
		  (#asTimeString asSlotDescriptor inline: true) }
]

Extension { #name : #DateAndTime }

{ #category : #'*Containers-Essentials-Visualizations' }
DateAndTime >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection , { 
		  ('asTimeZoneSymbol'
		   -> [ :anObj | anObj timeZone abbreviation asSymbol ]).
		  ('asISO8601String' -> [ :anObj | anObj asString ]).
		  #asLocalStringYMDHM.
		  #dayOfWeekName.
		  #monthName.
		  #month.
		  #dayOfMonth.
		  "		  ('Day of year' -> [ :anObj | anObj dayOfYear ])."
		  #year.
		  ('asTimeString' -> [ :anObj | anObj asTime asString ]) }
]

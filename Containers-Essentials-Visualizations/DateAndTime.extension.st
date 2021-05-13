Extension { #name : #DateAndTime }

{ #category : #'*Containers-Essentials-Visualizations' }
DateAndTime >> instVarsNamesOrderedCollection [

	^ super instVarsNamesOrderedCollection , { 
		  ('Timezone' -> [ :anObj | anObj timeZone ]).
		  ('ISO 8601 repr' -> [ :anObj | anObj asString ]).
		  ('Local repr' -> [ :anObj | anObj asLocalStringYMDHM ]).
		  ('Month name' -> [ :anObj | anObj monthName ]).
		  ('Month' -> [ :anObj | anObj month ]).
		  ('Day name' -> [ :anObj | anObj dayOfWeekName ]).
		  ('Day of month' -> [ :anObj | anObj dayOfMonth ]).
		  ('Day of year' -> [ :anObj | anObj dayOfYear ]).
		  ('Year' -> [ :anObj | anObj year ]) }
]

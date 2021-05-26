Extension { #name : #Duration }

{ #category : #'*Containers-Essentials-Visualizations' }
Duration >> instVarsNamesOrderedCollection [

	^ { 
		  #asDays.
		  #asHours.
		  #asMinutes.
		  #asSeconds.
		  #asMilliSeconds.
		  #asMicroseconds.
		  #asNanoSeconds.
		  ('d:hh:mm:ss[.µ]' -> [ :aDuration | aDuration asString asSymbol ]) }
]

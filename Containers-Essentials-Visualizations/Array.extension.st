Extension { #name : #Array }

{ #category : #'*Containers-Essentials-Visualizations' }
Array >> instVarsNamesOrderedCollection [

	| positions |
	positions := self withIndexCollect: [ :each :index | 
		             index asString -> [ :anObj | each ] ].

	^ super instVarsNamesOrderedCollection , positions
]

{ #category : #'*Containers-Essentials-Visualizations' }
Array >> propertyFromShape [

	^ self third
]

{ #category : #'*Containers-Essentials-Visualizations' }
Array >> propertyFromSlotShape [

	^ self second
]

{ #category : #'*Containers-Essentials-Visualizations' }
Array >> propertyToShape [

	^ self fourth
]

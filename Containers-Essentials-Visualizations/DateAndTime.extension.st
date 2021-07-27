Extension { #name : #DateAndTime }

{ #category : #'*Containers-Essentials-Visualizations' }
DateAndTime >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitDateAndTime: self
]

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

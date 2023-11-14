Extension { #name : 'DateAndTime' }

{ #category : '*Containers-Essentials' }
DateAndTime >> asISO8601String [

	^ self asString
]

{ #category : '*Containers-Essentials' }
DateAndTime >> asTimeString [

	^ self asTime asString
]

{ #category : '*Containers-Essentials' }
DateAndTime >> asTimeZoneString [

	^ self timeZone abbreviation
]

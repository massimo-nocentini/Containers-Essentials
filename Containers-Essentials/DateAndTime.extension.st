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

{ #category : '*Containers-Essentials' }
DateAndTime >> format: pattern locale: locale inLocalTime: inLocalTime [

	^ self
		  primitiveCompileThenFormat: pattern
		  timer: self asUnixTime
		  locale: locale
		  offset: self offset asSeconds
		  timezone: self timeZone abbreviation
		  local: inLocalTime
]

{ #category : '*Containers-Essentials' }
DateAndTime >> primitiveCompileThenFormat: p timer: t locale: l offset: o timezone: z local: s [

	<primitive: 'primitiveCompileThenFormat' module: 'DateTimeFormatterPlugin'>
	self primitiveFail
]

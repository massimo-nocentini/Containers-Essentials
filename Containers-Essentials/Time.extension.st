Extension { #name : 'Time' }

{ #category : '*Containers-Essentials' }
Time >> asFloatSeconds [

	^ self asSeconds asFloat + (nanos / NanosInSecond) asFloat
]

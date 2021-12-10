Extension { #name : #Duration }

{ #category : #'*Containers-Essentials' }
Duration >> asStringDHHMMSSµ [

	^ self asString
]

{ #category : #'*Containers-Essentials' }
Duration >> asStringScaledUptoHours [

	^ String streamContents: [ :aStream | 
		  self printScaledUptoHoursOn: aStream ]
]

{ #category : #'*Containers-Essentials' }
Duration class >> microSeconds: micros [

	^ self nanoSeconds: micros * 1e3
]

{ #category : #'*Containers-Essentials' }
Duration >> printOn: aStream scales: scales withRespectTo: aBlock [

	| base i scale |
	base := self asNanoSeconds.

	[ i := 1 ]
		for: [ 
			i <= scales size and: [ 
				| s |
				s := scales at: i.
				(base quo: s key) isZero ] ]
		do: [  ]
		then: [ i := i + 1 ].

	i := i min: scales size.
	scale := scales at: i.

	aStream
		nextPutAll: (base / scale key) asFloat asString;
		nextPutAll: ' ';
		nextPutAll: scale value
]

{ #category : #'*Containers-Essentials' }
Duration >> printScaledUptoHoursOn: aStream [

	self
		printOn: aStream
		scales: { 
				(3600e9 -> 'hour').
				(60e9 -> 'min').
				(1e9 -> 'sec').
				(1e6 -> 'millisec').
				(1e3 -> 'microsec').
				(1 -> 'nanosec') }
		withRespectTo: [ :aDuration | aDuration asNanoSeconds ]
]

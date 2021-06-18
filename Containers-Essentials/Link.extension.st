Extension { #name : #Link }

{ #category : #'*Containers-Essentials' }
Link >> next: anObject [

	^ anObject nextOfLink: self
]

{ #category : #'*Containers-Essentials' }
Link >> nextInteger: anInteger [

	| link |
	link := self.

	1 to: anInteger do: [ :i | 
		link
			ifNil: [ SubscriptOutOfBounds signalFor: i ]
			ifNotNil: [ link := link nextLink ] ].

	^ link
]

{ #category : #'*Containers-Essentials' }
Link >> nextOfLink: aLink [

	^ aLink nextLink: self
]

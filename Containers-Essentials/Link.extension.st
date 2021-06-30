Extension { #name : #Link }

{ #category : #'*Containers-Essentials' }
Link >> do: aBlock [

	| link |
	link := self.
	[ link ] whileNotNil: [ 
		aBlock value: link.
		link := link nextLink.
		link == self ifTrue: [ link := nil ] ]
]

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

{ #category : #'*Containers-Essentials' }
Link >> reversed [

	^ self reversed: nil
]

{ #category : #'*Containers-Essentials' }
Link >> reversed: aSuffix [

	^ self nextLink reversed: (self copy
			   nextLink: aSuffix;
			   yourself)
]

{ #category : #'*Containers-Essentials' }
Link >> size [

	| size nl |
	size := 1.
	nl := self.
	[ nl := nl nextLink ] whileNotNil: [ size := size + 1 ].
	^ size
]

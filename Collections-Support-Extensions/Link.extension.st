Extension { #name : #Link }

{ #category : #'*Collections-Support-Extensions' }
Link >> do: aBlock [
	| link |
	link := self.
	[ link isNotNil and: [ link nextLink ~= self ] ] whileTrue: [ 
		aBlock value: link.
		link := link nextLink ]
]

{ #category : #'*Collections-Support-Extensions' }
Link >> valueLinks [
	^ Array streamContents: [ :aStream | 
		  self do: [ :aValueLink | aStream nextPut: aValueLink ] ]
]

Extension { #name : #Link }

{ #category : #'*Collections-Support-Extensions' }
Link >> do: aBlock [
	| link |
	link := self.
	[ link ] whileNotNil: [ 
		aBlock value: link.
		link := link nextLink.
		link == self ifTrue: [ link := nil ] ]
]

{ #category : #'*Collections-Support-Extensions' }
Link >> recursiveReferences [
	^ Array streamContents: [ :aStream | 
		  self do: [ :aValueLink | aStream nextPut: aValueLink ] ]
]

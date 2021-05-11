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

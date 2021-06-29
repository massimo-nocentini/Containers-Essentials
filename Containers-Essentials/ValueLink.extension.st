Extension { #name : #ValueLink }

{ #category : #'*Containers-Essentials' }
ValueLink >> do: aBlock [

	^ super do: [ :each | aBlock value: each value ]
]

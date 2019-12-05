Extension { #name : #Object }

{ #category : #'*Collections-Unordered-Graph' }
Object >> asVertex [
	^ Vertex new
		content: self;
		yourself
]

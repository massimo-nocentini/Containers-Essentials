Extension { #name : #Symbol }

{ #category : #'*Collections-Strings-Extensions' }
Symbol >> value: recv value: arg [
	^ recv perform: self with: arg
]

{ #category : #'*Collections-Strings-Extensions' }
Symbol >> value: recv withArguments: args [
	^ recv perform: self withArguments: args
]

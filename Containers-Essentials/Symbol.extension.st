Extension { #name : 'Symbol' }

{ #category : '*Containers-Essentials' }
Symbol >> value: recv withArguments: args [
	^ recv perform: self withArguments: args
]

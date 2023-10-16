Extension { #name : 'Symbol' }

{ #category : '*Containers-Essentials' }
Symbol >> value: recv value: arg [
	^ recv perform: self with: arg
]

{ #category : '*Containers-Essentials' }
Symbol >> value: recv withArguments: args [
	^ recv perform: self withArguments: args
]

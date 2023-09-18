Extension { #name : 'CompiledMethod' }

{ #category : '*Containers-Essentials-Outliner' }
CompiledMethod >> docString [

	^ String cr , String cr join: (self ast comments collect: [ :each |
			   each sourceCode allButFirstAndLast ])
]

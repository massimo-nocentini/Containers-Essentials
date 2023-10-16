Extension { #name : 'CompiledCode' }

{ #category : '*Containers-Essentials' }
CompiledCode >> formattedCode [

	^ self sourceNode formattedCode
]

{ #category : '*Containers-Essentials' }
CompiledCode >> methodClassName [

	^ self methodClass name
]

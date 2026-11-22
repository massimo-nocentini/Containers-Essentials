Extension { #name : 'Duration' }

{ #category : '*Containers-Essentials' }
Duration >> asStringDHHMMSSµ [

	^ self asString
]

{ #category : '*Containers-Essentials' }
Duration >> squared [

	^ self class seconds: seconds squared nanoSeconds: nanos squared
]

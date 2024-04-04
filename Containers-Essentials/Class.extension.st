Extension { #name : 'Class' }

{ #category : '*Containers-Essentials' }
Class >> iceRepositoryIfAbsent: aBlock [

	^ IceRepository atPackage: self package ifAbsent: aBlock
]

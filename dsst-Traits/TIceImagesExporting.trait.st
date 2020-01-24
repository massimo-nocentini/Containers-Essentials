Trait {
	#name : #TIceImagesExporting,
	#category : #'dsst-Traits'
}

{ #category : #utilities }
TIceImagesExporting >> export: anObject filename: filename selector: aSelector [
	| mondrian |
	mondrian := RTMondrian new.
	anObject perform: aSelector with: mondrian.
	mondrian build view exportPNGtoFilename: filename.
	^ anObject
]

{ #category : #utilities }
TIceImagesExporting >> export: anObject path: aPath selector: aSelector [
	^ self export: anObject filename: aPath fullName selector: aSelector
]

{ #category : #utilities }
TIceImagesExporting >> iceWorkingDirectory [
	^ (IceRepository registry
		select: [ :repo | repo includesPackageNamed: self class category ])
		first location
]

{ #category : #utilities }
TIceImagesExporting >> imagesPath [
	^ self explicitRequirement
]

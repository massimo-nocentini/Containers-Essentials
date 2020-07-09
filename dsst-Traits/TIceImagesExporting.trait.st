Trait {
	#name : #TIceImagesExporting,
	#category : #'dsst-Traits'
}

{ #category : #utilities }
TIceImagesExporting >> export: anObject filename: filename selector: aSelector [
	| canvas |
	canvas := RSCanvas new.
	anObject perform: aSelector with: canvas.
	RSPNGExporter new
		canvas: canvas;
		exportToFile: filename asFileReference.
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

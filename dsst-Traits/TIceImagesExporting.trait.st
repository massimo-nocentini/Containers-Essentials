Trait {
	#name : #TIceImagesExporting,
	#category : #'dsst-Traits'
}

{ #category : #utilities }
TIceImagesExporting >> export: anObject filename: filename selector: aSelector [
	| canvas |
	canvas := RSCanvas new.
	anObject perform: aSelector with: canvas.
	RSSVGExporter new
		canvas: canvas;
		zoomToShapes;
		fileName: filename;
		export.
	^ anObject
]

{ #category : #utilities }
TIceImagesExporting >> export: anObject path: aPath selector: aSelector [
	^ self export: anObject filename: aPath fullName selector: aSelector
]

{ #category : #utilities }
TIceImagesExporting >> export: anObject pathSuffix: aFilename selector: aSelector [

	^ self
		  export: anObject
		  path: self imagesPath
			  /
				  (thisContext receiver class name , '-'
				   , thisContext receiver selector
				   , (aFilename ifNotEmpty: [ '-' , aFilename ]))
		  selector: aSelector
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

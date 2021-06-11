Trait {
	#name : #TIceImagesExporting,
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #utilities }
TIceImagesExporting >> export: anObject filename: filename onCanvasDo: aSelector [

	| canvas |
	canvas := RSCanvas new.
	aSelector value: canvas value: anObject.
	RSSVGExporter new
		canvas: canvas;
		zoomToShapes;
		fileName: filename;
		export.
	^ anObject
]

{ #category : #utilities }
TIceImagesExporting >> export: anObject path: aPath onCanvasDo: aSelector [

	^ self export: anObject filename: aPath fullName onCanvasDo: aSelector
]

{ #category : #utilities }
TIceImagesExporting >> export: anObject pathSuffix: aFilename onCanvasDo: aBlock [

	| suffix |
	suffix := thisContext receiver class name , '-'
	          , thisContext receiver selector
	          , (aFilename ifNotEmpty: [ '-' , aFilename ]).
	^ self
		  export: anObject
		  path: self imagesPath / suffix
		  onCanvasDo: aBlock
]

{ #category : #utilities }
TIceImagesExporting >> exportSlotsGraphOf: anObject [

	^ self
		  exportSlotsGraphOf: anObject
		  slotsBlock: [ :anObj | anObj instVarsNamesOrderedCollection ]
]

{ #category : #utilities }
TIceImagesExporting >> exportSlotsGraphOf: anObject slotsBlock: aBlock [

	^ self export: anObject pathSuffix: '' onCanvasDo: [ :aCanvas :obj | 
		  obj
			  treeDrawer: CTSlotsDfsTreeDrawer new
			  onCanvas: aCanvas
			  slotsBlock: aBlock ]
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

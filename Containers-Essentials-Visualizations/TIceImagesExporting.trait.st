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
		zoomToShapesWithPadding: Float goldenRatio double double;
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
TIceImagesExporting >> exportShapeOf: anObject accessorBlock: aBlock [

	^ self exportShapeOf: anObject accessorBlock: aBlock pathSuffix: ''
]

{ #category : #utilities }
TIceImagesExporting >> exportShapeOf: anObject accessorBlock: aBlock pathSuffix: aSuffix [

	^ self
		  export: anObject
		  pathSuffix: aSuffix
		  onCanvasDo: [ :aCanvas :obj | aCanvas add: (aBlock value: obj) ]
]

{ #category : #utilities }
TIceImagesExporting >> exportSlotsGraphOf: anObject [

	^ self
		  exportSlotsGraphOf: anObject
		  slotDescriptorsContext: SlotDescriptorsVisitor new
]

{ #category : #utilities }
TIceImagesExporting >> exportSlotsGraphOf: anObject pathSuffix: aSuffix [

	^ self
		  exportSlotsGraphOf: anObject
		  slotDescriptorsContext: SlotDescriptorsVisitor new
		  pathSuffix: aSuffix
]

{ #category : #utilities }
TIceImagesExporting >> exportSlotsGraphOf: anObject slotDescriptorsContext: aSlotDescriptorsContext [

	^ self
		  exportSlotsGraphOf: anObject
		  slotDescriptorsContext: aSlotDescriptorsContext
		  pathSuffix: ''
]

{ #category : #utilities }
TIceImagesExporting >> exportSlotsGraphOf: anObject slotDescriptorsContext: aSlotDescriptorsContext pathSuffix: aSuffix [

	^ self
		  export: anObject
		  pathSuffix: aSuffix
		  onCanvasDo: [ :aCanvas :obj | 
			  | aShape |
			  aShape := aSlotDescriptorsContext
				            draw: anObject
				            using: CTSlotsDfsTreeDrawer new
				            walking: CTObjectRefsVisit new.

			  aCanvas add: aShape ]
]

{ #category : #utilities }
TIceImagesExporting >> iceWorkingDirectory [
	^ (IceRepository registry
		select: [ :repo | repo includesPackageNamed: self class category ])
		first location
]

{ #category : #utilities }
TIceImagesExporting >> imagesPath [

	^ self iceWorkingDirectory / 'images'
]

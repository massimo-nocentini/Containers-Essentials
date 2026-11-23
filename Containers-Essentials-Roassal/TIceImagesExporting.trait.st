"
I export shapes and graphs of objects as SVG images. My users are test cases: a file is named after the class and the selector of the test that runs, as in `EssentialsObjectTest-testInspectPoint.svg`, with a suffix if one is given.

- `exportSlotsGraphOf:` exports the outliners that a `CTDfsWalker` makes from an object. The argument `slotDescriptorsVisitor:` is the visitor of the walker, and `pathSuffix:` the suffix.
- `exportCompiledMethod:` does it for a method, whose name is the suffix, and `exportImplementorsOf:` for all the implementors of a selector.
- `exportShapeOf:` exports a shape, and `exportShapeOf:accessorBlock:` the shape that a block, or a selector, makes from an object.
- `export:pathSuffix:onCanvasDo:` exports a canvas after giving it and an object to a block, and `export:pathSuffix:selector:` after giving it to the object as the argument of a message.

All of them answer the object, so that a test can answer it too, except `exportImplementorsOf:`.

```smalltalk
(EssentialsObjectTest selector: #testInspectPoint)
	exportSlotsGraphOf: 42 @ 24 ""42@24""
```

The images go to `imagesPath`, the directory `images` of the working copy of the Iceberg repository that has the package of my user, or of the image directory when there is none.

`svgExporter` answers the exporter, which my users can override; `pdfExporter` answers one for PDF files, which no method of mine uses.
"
Trait {
	#name : 'TIceImagesExporting',
	#category : 'Containers-Essentials-Roassal',
	#package : 'Containers-Essentials-Roassal'
}

{ #category : 'utilities' }
TIceImagesExporting >> export: anObject filename: filename onCanvasDo: aSelector [

	| canvas |
	canvas := RSCanvas new
		          useRTree;
		          yourself.

	aSelector value: canvas value: anObject.

	"noDoubleDraw after zoomToShapesWithPadding:, which installs a new camera setter: otherwise the
	setter draws the whole canvas on a Form first, out of memory for a large graph"
	self svgExporter
		canvas: canvas;
		zoomToShapesWithPadding: Float goldenPlatinumRatio double;
		noDoubleDraw;
		fileName: filename;
		export.

	^ anObject
]

{ #category : 'utilities' }
TIceImagesExporting >> export: anObject path: aPath onCanvasDo: aSelector [

	^ self export: anObject filename: aPath fullName onCanvasDo: aSelector
]

{ #category : 'utilities' }
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

{ #category : 'utilities' }
TIceImagesExporting >> export: anObject pathSuffix: aFilename selector: selector [

	^ self
		  export: anObject
		  pathSuffix: aFilename
		  onCanvasDo: [ :canvas :obj | obj perform: selector with: canvas ]
]

{ #category : 'utilities' }
TIceImagesExporting >> exportCompiledMethod: aCompiledMethod [

	^ self
		  exportSlotsGraphOf: aCompiledMethod
		  pathSuffix:
			  (((aCompiledMethod printString copyReplaceAll: ' ' with: '_')
				    copyReplaceAll: ':'
				    with: '-') copyReplaceAll: '>>#' with: '-')
]

{ #category : 'utilities' }
TIceImagesExporting >> exportImplementorsOf: aSelector [

	aSelector implementors do: [ :aCompiledMethod | 
		self exportCompiledMethod: aCompiledMethod ]
]

{ #category : 'utilities' }
TIceImagesExporting >> exportShapeOf: anObject [

	^ self exportShapeOf: anObject accessorBlock: [ :aShape | aShape ]
]

{ #category : 'utilities' }
TIceImagesExporting >> exportShapeOf: anObject accessorBlock: aBlock [

	^ self exportShapeOf: anObject accessorBlock: aBlock pathSuffix: ''
]

{ #category : 'utilities' }
TIceImagesExporting >> exportShapeOf: anObject accessorBlock: aBlock pathSuffix: aSuffix [

	^ self
		  export: anObject
		  pathSuffix: aSuffix
		  onCanvasDo: [ :aCanvas :obj | aCanvas add: (aBlock value: obj) ]
]

{ #category : 'utilities' }
TIceImagesExporting >> exportSlotsGraphOf: anObject [

	^ self
		  exportSlotsGraphOf: anObject
		  slotDescriptorsVisitor: CTSlotDescriptorsVisitor new
]

{ #category : 'utilities' }
TIceImagesExporting >> exportSlotsGraphOf: anObject pathSuffix: aSuffix [

	^ self
		  exportSlotsGraphOf: anObject
		  slotDescriptorsVisitor: CTSlotDescriptorsVisitor new
		  pathSuffix: aSuffix
]

{ #category : 'utilities' }
TIceImagesExporting >> exportSlotsGraphOf: anObject slotDescriptorsVisitor: aVisitor [

	^ self
		  exportSlotsGraphOf: anObject
		  slotDescriptorsVisitor: aVisitor
		  pathSuffix: ''
]

{ #category : 'utilities' }
TIceImagesExporting >> exportSlotsGraphOf: anObject slotDescriptorsVisitor: aVisitor pathSuffix: aSuffix [

	^ self
		  export: anObject
		  pathSuffix: aSuffix
		  onCanvasDo: [ :aCanvas :obj | 
			  | aShape walker |
			  walker := CTDfsWalker new.

			  walker slotDescriptorsVisitor: aVisitor.

			  aShape := obj asShapeSlotsDfsTree: walker.

			  aCanvas add: aShape ]
]

{ #category : 'utilities' }
TIceImagesExporting >> iceWorkingDirectory [
	"The working copy of the Iceberg repository of my package, or the image directory when Iceberg has none, as after a load from a tonel:// directory"

	^ IceRepository registry
		  detect: [ :repo |
			  repo location notNil and: [
				  repo includesPackageNamed: self class package name ] ]
		  ifFound: [ :repo | repo location ]
		  ifNone: [ FileLocator imageDirectory asFileReference ]
]

{ #category : 'utilities' }
TIceImagesExporting >> imagesPath [

	^ (self iceWorkingDirectory / 'images') createDirectory
]

{ #category : 'utilities' }
TIceImagesExporting >> pdfExporter [

	^ RSPDFCairoExporter new
]

{ #category : 'utilities' }
TIceImagesExporting >> svgExporter [

	^ RSSVGCairoExporter new
]

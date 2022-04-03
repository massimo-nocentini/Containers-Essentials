Extension { #name : #Behavior }

{ #category : #'*Containers-Essentials-Visualizations' }
Behavior >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitBehavior: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Behavior >> asShapeAllSuperclassesIndented: aBlock [

	^ self
		  asShapeAllSuperclassesIndented:
		  self allSuperclasses reversed , { self }
		  collect: aBlock
]

{ #category : #'*Containers-Essentials-Visualizations' }
Behavior >> asShapeAllSuperclassesIndented: aCollection collect: shapeBlock [

	| superClassShapes |
	superClassShapes := aCollection collect: shapeBlock.

	RSVerticalLineLayout new
		verticalGap: Float goldenRatio negated;
		alignLeft;
		on: superClassShapes.

	superClassShapes withIndexDo: [ :aShape :times | 
		| offset |
		offset := Float goldenRatio double * times.
		aShape position: aShape position x + offset @ aShape position y ].

	^ RSComposite new
		  model: self;
		  shapes: superClassShapes;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Behavior >> asShapeClass: aBlock [

	^ self asShapeAllSuperclassesIndented: { self } collect: aBlock
]

{ #category : #'*Containers-Essentials-Visualizations' }
Behavior >> asShapeSubclasses [

	| gr commits edges |
	gr := Float goldenRatio.
	commits := Array streamContents: [ :aStream | 
		           self withAllSubclassesDo: [ :aSubClass | 
			           | aShape |
			           aShape := RSLabel new
				                     text: aSubClass name;
				                     when: RSMouseLeftClick
				                     do: [ :ev | aSubClass browse ];
				                     yourself.

			           aShape := (aShape notedWithPad:
					                      Float goldenPlatinumRatio)
				                     model: aSubClass;
				                     yourself.

			           aStream nextPut: aShape ] ].

	edges := RSLineBuilder horizontalDeCasteljauSegmentedLine
		         shapes: commits;
		         withHorizontalAttachPoint;
		         cornerRadii: Float goldenRatio double;
		         connectToAll: [ :aSubClass | aSubClass subclasses ].

	edges do: [ :each | each color: each color translucent ].

	edges sort: [ :a :b | 
		| aName bName |
		aName := a from model name.
		bName := b from model name.
		aName = bName
			ifTrue: [ a to model name < b to model name ]
			ifFalse: [ aName < bName ] ].

	RSHorizontalGaussianJitterVanDerPloegTreeLayout new
		doNotValidateCycles;
		usePyramidalDepthGaps;
		on: commits edges: edges.

	^ RSComposite new
		  shapes: commits , edges;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Behavior >> inspectorCanvasSubclassesTree [

	<inspectorPresentationOrder: 1000 title: 'All subclasses tree'>
	^ RSCanvas new
		  add: self asShapeSubclasses;
		  @ RSCanvasController;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Behavior >> inspectorCanvasSubclassesTreeContext: aContext [

	aContext withoutEvaluator
]

Extension { #name : #Object }

{ #category : #'*Kernel-Visualizations' }
Object >> drawSCCsOfSlotsGraphOnCanvas: aCanvas referencesBlock: aBlock [

	| fromShapes toShapes sccs sccsShapes layoutAssociations shapesAssociations shapeBySCC eb edges |
	fromShapes := IdentityDictionary new.
	toShapes := IdentityDictionary new.
	sccs := OrderedCollection new.
	shapeBySCC := IdentityDictionary new.

	CTObjectRefsVisit new
		fromShapes: fromShapes;
		toShapes: toShapes;
		stronglyConnectedComponents: sccs;
		forObject: self slotsMap: self instVarsNamesOrderedCollection.

	sccsShapes := sccs collect: [ :scc | 
		              | box composite shapes padding |
		              padding := 2.

		              shapes := scc sorted: [ :aShape :anotherShape | 
			                        (aShape propertyAt: #dfsTimings) x
			                        < (anotherShape propertyAt: #dfsTimings) x ].

		              RSCircleLayout on: shapes.

		              composite := RSComposite new
			                           shapes: shapes;
			                           padding: padding;
			                           yourself.

		              box := RSBox new
			                     model: scc;
			                     color: Color white;
			                     extent: composite extent;
			                     yourself: [ :aBox | 
				                     scc size > 1
					                     ifTrue: [ 
						                     aBox
							                     withBorder;
							                     cornerRadius: 2 ]
					                     ifFalse: [ padding := 0 ] ].

		              RSLocation new inner stick: composite on: box.

		              RSComposite new
			              model: scc;
			              shapes: { 
					              box.
					              composite };
			              padding: padding;
			              addInteraction: RSDraggable new;
			              yourself: [ :aComposite | 
				              shapeBySCC at: scc put: aComposite ] ].

	aCanvas addAll: sccsShapes.

	layoutAssociations := Dictionary new.
	shapesAssociations := OrderedCollection new.

	(fromShapes associations sorted: [ :anAssoc :anotherAssoc | 
		 ((toShapes at: anAssoc key model) propertyAt: #dfsTimings) x
		 < ((toShapes at: anotherAssoc key model) propertyAt: #dfsTimings) x ]) 
		do: [ :anAssociation | 
			| boxShape boxParentShape toShape toSCCShape fromSCCShape |
			boxShape := anAssociation key.
			boxParentShape := anAssociation value.
			toShape := toShapes at: boxShape model.
			toSCCShape := shapeBySCC at: (toShape propertyAt: #scc).
			fromSCCShape := shapeBySCC at: (boxParentShape propertyAt: #scc).

			fromSCCShape == toSCCShape
				ifTrue: [ shapesAssociations add: boxShape -> toShape ]
				ifFalse: [ 
					shapesAssociations add: boxShape -> toSCCShape.

					((toShape propertyAt: #bfsLevel)
					 - (boxParentShape propertyAt: #bfsLevel) = 1 and: [ 
						 | fromTiming toTiming |
						 fromTiming := boxParentShape propertyAt: #dfsTimings.
						 toTiming := toShape propertyAt: #dfsTimings.
						 fromTiming x < toTiming x and: [ toTiming y < fromTiming y ] ]) 
						ifTrue: [ 
							layoutAssociations
								at: fromSCCShape -> toSCCShape
								ifAbsentPut: [ layoutAssociations size + 1 ] ] ] ].

	"This will add edges directly to the canvas."
	(RSLineBuilder new: self lineShape)
		canvas: aCanvas;
		useElementAssociations: shapesAssociations.



	aCanvas edges do: [ :edge | 
		| fromTiming toTiming |
		edge color: edge color lighter lighter lighter

		"fromTiming := (fromShapes at: edge from) propertyAt: #dfsTimings.
		toTiming := edge to propertyAt: #dfsTimings.
		(toTiming x < fromTiming x and: [ fromTiming y < toTiming y ])
			ifTrue: [ edge dashArray: #( 4 ) ]
			ifFalse: [ 
			toTiming y < fromTiming x ifTrue: [ edge dashArray: #( 1 ) ] ]" ].

	eb := RSLineBuilder line.
	edges := (layoutAssociations associations sorted: [ 
		          :anAssociation 
		          :anotherAssociation | 
		          anAssociation value < anotherAssociation value ]) 
		         collect: [ :aNestedAssociation | 
			         | anAssociation |
			         anAssociation := aNestedAssociation key.
			         eb edgeFrom: anAssociation key to: anAssociation value ].

	RSHorizontalTreeLayout on: sccsShapes edges: edges.

	^ aCanvas
		  exportToSVG;
		  yourself
]

{ #category : #'*Kernel-Visualizations' }
Object >> drawSlotsGraphOnCanvas: aCanvas referencesBlock: f [

	| fromShapes toShapes shapesAssociations layoutAssociations edges eb |
	fromShapes := IdentityDictionary new.
	toShapes := IdentityDictionary new.


	CTObjectRefsVisit new
		fromShapes: fromShapes;
		toShapes: toShapes;
		maxLevel: 0;
		forObject: self slotsMap: self instVarsNamesOrderedCollection.

	aCanvas addAll: toShapes values.

	layoutAssociations := Dictionary new.
	shapesAssociations := OrderedCollection new.

	(fromShapes associations sorted: [ :anAssoc :anotherAssoc | 
		 ((toShapes at: anAssoc key model) propertyAt: #dfsTimings) x
		 < ((toShapes at: anotherAssoc key model) propertyAt: #dfsTimings) x ]) 
		do: [ :anAssociation | 
			| boxShape boxParentShape toShape |
			boxShape := anAssociation key.
			boxParentShape := anAssociation value.
			toShape := toShapes at: boxShape model.
			shapesAssociations add: boxShape -> toShape.

			((toShape propertyAt: #bfsLevel)
			 - (boxParentShape propertyAt: #bfsLevel) = 1 and: [ 
				 | fromTiming toTiming |
				 fromTiming := boxParentShape propertyAt: #dfsTimings.
				 toTiming := toShape propertyAt: #dfsTimings.
				 fromTiming x < toTiming x and: [ toTiming y < fromTiming y ] ]) 
				ifTrue: [ 
					layoutAssociations
						at: boxParentShape -> toShape
						ifAbsentPut: [ layoutAssociations size + 1 ] ] ].

	"This will add edges directly to the canvas."
	(RSLineBuilder new: self lineShape)
		canvas: aCanvas;
		useElementAssociations: shapesAssociations.

	aCanvas edges do: [ :edge | 
		| fromTiming toTiming |
		edge color: edge color lighter lighter lighter.

		fromTiming := (fromShapes at: edge from) propertyAt: #dfsTimings.
		toTiming := edge to propertyAt: #dfsTimings.
		(toTiming x < fromTiming x and: [ fromTiming y < toTiming y ])
			ifTrue: [ edge dashArray: #( 4 ) ]
			ifFalse: [ 
			toTiming y < fromTiming x ifTrue: [ edge dashArray: #( 1 ) ] ] ].

	eb := RSLineBuilder line.
	edges := (layoutAssociations associations sorted: [ 
		          :anAssociation 
		          :anotherAssociation | 
		          anAssociation value < anotherAssociation value ]) 
		         collect: [ :aNestedAssociation | 
			         | anAssociation |
			         anAssociation := aNestedAssociation key.
			         eb edgeFrom: anAssociation key to: anAssociation value ].

	RSHorizontalTreeLayout on: aCanvas nodes edges: edges.

	^ aCanvas
		  exportToSVG;
		  yourself
]

{ #category : #'*Kernel-Visualizations' }
Object >> drawTopologicallySortedSlotsGraphOnCanvas: aCanvas referencesBlock: aBlock [

	| fromShapes toShapes shapesAssociations |
	fromShapes := IdentityDictionary new.
	toShapes := IdentityDictionary new.

	CTObjectRefsVisit new
		fromShapes: fromShapes;
		toShapes: toShapes;
		forObject: self slotsMap: self instVarsNamesOrderedCollection.

	aCanvas addAll: (toShapes values sorted: [ :aShape :anotherShape | 
			 (aShape propertyAt: #dfsTimings) y
			 > (anotherShape propertyAt: #dfsTimings) y ]).

	shapesAssociations := OrderedCollection new.

	(fromShapes associations sorted: [ :anAssoc :anotherAssoc | 
		 ((toShapes at: anAssoc key model) propertyAt: #dfsTimings) x
		 < ((toShapes at: anotherAssoc key model) propertyAt: #dfsTimings) x ]) 
		do: [ :anAssociation | 
			| boxShape boxParentShape toShape |
			boxShape := anAssociation key.
			boxParentShape := anAssociation value.
			toShape := toShapes at: boxShape model.
			shapesAssociations add: boxShape -> toShape ].

	"This will add edges directly to the canvas."
	(RSLineBuilder new: self lineShape)
		canvas: aCanvas;
		useElementAssociations: shapesAssociations.

	aCanvas edges do: [ :edge | 
		| fromTiming toTiming |
		edge color: edge color lighter lighter lighter.

		fromTiming := (fromShapes at: edge from) propertyAt: #dfsTimings.
		toTiming := edge to propertyAt: #dfsTimings.
		(toTiming x < fromTiming x and: [ fromTiming y < toTiming y ])
			ifTrue: [ edge dashArray: #( 4 ) ]
			ifFalse: [ 
			toTiming y < fromTiming x ifTrue: [ edge dashArray: #( 1 ) ] ] ].

	RSVerticalLineLayout new alignCenter applyOn: aCanvas nodes.

	^ aCanvas
		  exportToSVG;
		  yourself
]

{ #category : #'*Kernel-Visualizations' }
Object >> inspectorCanvasSlotsGraph [

	<inspectorPresentationOrder: 30 title: 'Slots graph'>
	| canvas |
	canvas := self
		          drawSlotsGraphOnCanvas: RSCanvas new
		          referencesBlock: [ :anObj | 
		          anObj instVarsNamesOrderedCollection ].
	^ canvas
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Kernel-Visualizations' }
Object >> inspectorCanvasSlotsGraphContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Kernel-Visualizations' }
Object >> inspectorCanvasSlotsGraphSCCs [

	<inspectorPresentationOrder: 50 title: 'SCCs of Slots graph'>
	| canvas |
	canvas := self
		          drawSCCsOfSlotsGraphOnCanvas: RSCanvas new
		          referencesBlock: [ :anObj | 
		          anObj instVarsNamesOrderedCollection ].
	^ canvas
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Kernel-Visualizations' }
Object >> inspectorCanvasSlotsGraphSCCsContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Kernel-Visualizations' }
Object >> inspectorCanvasSlotsGraphTopologicallySorted [

	<inspectorPresentationOrder: 40 title: 'Slots graph, topologically sorted.'>
	| canvas |
	canvas := self
		          drawTopologicallySortedSlotsGraphOnCanvas: RSCanvas new
		          referencesBlock: [ :anObj | anObj instVarsNamesOrderedCollection ].
	^ canvas
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Kernel-Visualizations' }
Object >> inspectorCanvasSlotsGraphTopologicallySortedContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Kernel-Visualizations' }
Object >> instVarsNamesOrderedCollection [

	^ self class allInstVarNames collect: [ :varName | 
		  varName -> [ :anObj | anObj instVarNamed: varName ] ]
]

{ #category : #'*Kernel-Visualizations' }
Object >> lineShape [

	| controller |
	controller := RSStartEndCPAPController new
		              controller: RSDirectedBezierCPAPController new;
		              startAttachPoint: RSCenteredAttachPoint new;
		              endAttachPoint: RSBorderAttachPoint new;
		              yourself.
	^ RSBezier new
		  "cornerRadii: 2;"
		  "markerEnd: RSArrowedLine new defaultHead asMarker;"
		  controlPointsController: controller;
		  yourself
	"		  border: (RSBorder new color: Color gray lighter lighter);"
]

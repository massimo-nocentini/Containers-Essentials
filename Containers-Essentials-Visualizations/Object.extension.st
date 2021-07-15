Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsCollapsedSCCsDfsTree [

	^ self
		  asShapeTreeDrawer: CTSlotsCollapsedSCCsDfsTreeDrawer new
		  slotsBlock: [ :anObj | anObj instVarsNamesOrderedCollection ]
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsDfsTree [

	^ self
		  asShapeTreeDrawer: CTSlotsDfsTreeDrawer new
		  slotsBlock: [ :anObj | anObj instVarsNamesOrderedCollection ]
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsLayeredDfsTree [

	^ self
		  asShapeTreeDrawer: CTSlotsLayeredDfsTreeDrawer new
		  slotsBlock: [ :anObj | anObj instVarsNamesOrderedCollection ]
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsSCCsDfsTree [

	^ self
		  asShapeTreeDrawer: CTSlotsSCCsDfsTreeDrawer new
		  slotsBlock: [ :anObj | anObj instVarsNamesOrderedCollection ]
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsTopologicallySortedDfsTree [

	^ self
		  asShapeTreeDrawer: CTSlotsTopologicallySortedDfsTreeDrawer new
		  slotsBlock: [ :anObj | anObj instVarsNamesOrderedCollection ]
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeTreeDrawer: aDrawer slotsBlock: aBlock [

	^ aDrawer visit: (CTObjectRefsVisit new
			   rootObject: self;
			   slotsBlock: aBlock;
			   yourself)
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraph [

	<inspectorPresentationOrder: 100 title: 'Slots graph'>
	^ RSCanvas new
		  add: self asShapeSlotsDfsTree;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraphCollapsedSCCs [

	<inspectorPresentationOrder: 130 title:
	'Collapsed SCCs of Slots graph'>
	^ RSCanvas new
		  add: self asShapeSlotsCollapsedSCCsDfsTree;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraphCollapsedSCCsContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraphContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraphLayered [

	<inspectorPresentationOrder: 150 title: 'Layered slots graph'>
	^ RSCanvas new
		  add: self asShapeSlotsLayeredDfsTree;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraphLayeredContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraphSCCs [

	<inspectorPresentationOrder: 120 title: 'SCCs of Slots graph'>
	^ RSCanvas new
		  add: self asShapeSlotsSCCsDfsTree;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraphSCCsContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraphTopologicallySorted [

	<inspectorPresentationOrder: 110 title:
	'Slots graph, topologically sorted.'>
	^ RSCanvas new
		  add: self asShapeSlotsTopologicallySortedDfsTree;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraphTopologicallySortedContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> instVarsNamesOrderedCollection [

	^ self class allInstVarNames collect: [ :varName | 
		  varName asSlotDescriptor instVarNameHasBeenGiven ]
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> instVarsNamesOrderedCollection_testMagnitudeSubclassesSlotsGraph [

	^ self instVarsNamesOrderedCollection
]

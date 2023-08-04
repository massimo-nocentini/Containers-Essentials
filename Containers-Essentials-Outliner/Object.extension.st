Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Outliner' }
Object >> inspectorCanvasSlotsGraph [

	<inspectorPresentationOrder: 1000 title: 'Slots graph'>
	| walker shape |
	walker := CTDfsWalker new.

	shape := self asShapeSlotsDfsTree: walker.

	^ RSCanvas new
		  add: shape;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Outliner' }
Object >> inspectorCanvasSlotsGraphCollapsedSCCs [

	"<inspectorPresentationOrder: 1002 title:
	'Collapsed SCCs of Slots graph'>"

	| walker shape |
	walker := CTDfsWalker new.

	shape := self asShapeSlotsCollapsedSCCsDfsTree: walker.

	^ RSCanvas new
		  add: shape;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Outliner' }
Object >> inspectorCanvasSlotsGraphCollapsedSCCsContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Outliner' }
Object >> inspectorCanvasSlotsGraphContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Outliner' }
Object >> inspectorCanvasSlotsGraphLayered [

	<inspectorPresentationOrder: 1004 title: 'Layered slots graph'>
	| walker shape |
	walker := CTDfsWalker new.

	shape := self asShapeSlotsLayeredDfsTree: walker.

	^ RSCanvas new
		  add: shape;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Outliner' }
Object >> inspectorCanvasSlotsGraphLayeredContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Outliner' }
Object >> inspectorCanvasSlotsGraphSCCs [

	<inspectorPresentationOrder: 1001 title: 'SCCs of Slots graph'>
	| walker shape |
	walker := CTDfsSCCsWalker new.

	shape := self asShapeSlotsSCCsDfsTree: walker.

	^ RSCanvas new
		  add: shape;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Outliner' }
Object >> inspectorCanvasSlotsGraphSCCsContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Outliner' }
Object >> inspectorCanvasSlotsGraphTopologicallySorted [

	<inspectorPresentationOrder: 1003 title:
	'Slots graph, topologically sorted.'>
	| walker shape |
	walker := CTDfsWalker new.

	shape := self asShapeSlotsTopologicallySortedDfsTree: walker.

	^ RSCanvas new
		  add: shape;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Outliner' }
Object >> inspectorCanvasSlotsGraphTopologicallySortedContext: aContext [

	aContext withoutEvaluator
]

{ #category : #'*Containers-Essentials-Outliner' }
Object >> isNotebookHideReason [

	^ false
]

{ #category : #'*Containers-Essentials-Outliner' }
Object >> isObjectHolder [

	^ false
]

Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Outliner' }
Object >> inspectorCanvasSlotsGraph [

	<inspectorPresentationOrder: 1000 title: 'Slots graph'>
	^ RSCanvas new
		  add: (self asShapeSlotsDfsTree: CTSlotDescriptorsVisitor new);
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Outliner' }
Object >> inspectorCanvasSlotsGraphCollapsedSCCs [

	<inspectorPresentationOrder: 1002 title:
	'Collapsed SCCs of Slots graph'>
	^ RSCanvas new
		  add:
			  (self asShapeSlotsCollapsedSCCsDfsTree:
					   CTSlotDescriptorsVisitor new);
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
	^ RSCanvas new
		  add: (self asShapeSlotsLayeredDfsTree: CTSlotDescriptorsVisitor new);
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
	^ RSCanvas new
		  add: (self asShapeSlotsSCCsDfsTree: CTSlotDescriptorsVisitor new);
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
	^ RSCanvas new
		  add: (self asShapeSlotsTopologicallySortedDfsTree:
					   CTSlotDescriptorsVisitor new);
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Outliner' }
Object >> inspectorCanvasSlotsGraphTopologicallySortedContext: aContext [

	aContext withoutEvaluator
]

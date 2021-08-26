Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitObject: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsCollapsedSCCsDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeTreeDrawer: CTSlotsCollapsedSCCsDfsTreeDrawer new
		  slotDescriptorsContext: aSlotDescriptorsContext
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeTreeDrawer: CTSlotsDfsTreeDrawer new
		  slotDescriptorsContext: aSlotDescriptorsContext
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsLayeredDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeTreeDrawer: CTSlotsLayeredDfsTreeDrawer new
		  slotDescriptorsContext: aSlotDescriptorsContext
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsSCCsDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeTreeDrawer: CTSlotsSCCsDfsTreeDrawer new
		  slotDescriptorsContext: aSlotDescriptorsContext
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsTopologicallySortedDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeTreeDrawer: CTSlotsTopologicallySortedDfsTreeDrawer new
		  slotDescriptorsContext: aSlotDescriptorsContext
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeTreeDrawer: aDrawer slotDescriptorsContext: aSlotDescriptorsContext [

	^ aSlotDescriptorsContext
		  draw: self
		  using: aDrawer
		  walking: CTObjectRefsVisit new
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraph [

	<inspectorPresentationOrder: 100 title: 'Slots graph'>
	^ RSCanvas new
		  add: (self asShapeSlotsDfsTree: CTSlotDescriptorsVisitor new);
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraphCollapsedSCCs [

	<inspectorPresentationOrder: 130 title:
	'Collapsed SCCs of Slots graph'>
	^ RSCanvas new
		  add:
			  (self asShapeSlotsCollapsedSCCsDfsTree:
					   CTSlotDescriptorsVisitor new);
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
		  add: (self asShapeSlotsLayeredDfsTree: CTSlotDescriptorsVisitor new);
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
		  add: (self asShapeSlotsSCCsDfsTree: CTSlotDescriptorsVisitor new);
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
		  add: (self asShapeSlotsTopologicallySortedDfsTree:
					   CTSlotDescriptorsVisitor new);
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraphTopologicallySortedContext: aContext [

	aContext withoutEvaluator
]

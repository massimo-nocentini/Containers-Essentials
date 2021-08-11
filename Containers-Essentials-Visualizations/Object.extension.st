Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitObject: self
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsCollapsedSCCsDfsTree [

	^ self
		  asShapeTreeDrawer: CTSlotsCollapsedSCCsDfsTreeDrawer new
		  slotsBlock: [ :anObj | anObj instVarsNamesOrderedCollection ]
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeSlotsDfsTree: aSlotDescriptorsContext [

	^ self
		  asShapeTreeDrawer: CTSlotsDfsTreeDrawer new
		  slotDescriptorsContext: aSlotDescriptorsContext
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
Object >> asShapeTreeDrawer: aDrawer slotDescriptorsContext: aSlotDescriptorsContext [

	^ aSlotDescriptorsContext
		  draw: self
		  using: aDrawer
		  walking: CTObjectRefsVisit new
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeTreeDrawer: aDrawer slotsBlock: aBlock [

	^ self
		  asShapeTreeDrawer: aDrawer
		  slotsBlock: aBlock
		  initialDescriptor: #yourself asSlotDescriptor
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> asShapeTreeDrawer: aDrawer slotsBlock: aBlock initialDescriptor: aDescriptor [

	^ aDrawer visit: (CTObjectRefsVisit new
			   rootObject: self;
			   slotDescriptorsContext: aBlock;
			   yourself)
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraph [

	<inspectorPresentationOrder: 100 title: 'Slots graph'>
	^ RSCanvas new
		  add: (self asShapeSlotsDfsTree: SlotDescriptorsVisitor new);
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

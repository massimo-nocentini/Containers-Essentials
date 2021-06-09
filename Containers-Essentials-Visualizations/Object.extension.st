Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraph [

	<inspectorPresentationOrder: 100 title: 'Slots graph'>
	| canvas |
	canvas := self
		          treeDrawer: CTSlotsDfsTreeDrawer new
		          onCanvas: RSCanvas new
		          slotsBlock: [ :anObj | 
		          anObj instVarsNamesOrderedCollection ].
	^ canvas
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraphCollapsedSCCs [

	<inspectorPresentationOrder: 130 title:
	'Collapsed SCCs of Slots graph'>
	| canvas |
	canvas := self
		          treeDrawer: CTSlotsCollapsedSCCsDfsTreeDrawer new
		          onCanvas: RSCanvas new
		          slotsBlock: [ :anObj | 
		          anObj instVarsNamesOrderedCollection ].
	^ canvas
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
Object >> inspectorCanvasSlotsGraphSCCs [

	<inspectorPresentationOrder: 120 title: 'SCCs of Slots graph'>
	| canvas |
	canvas := self
		          treeDrawer: CTSlotsSCCsDfsTreeDrawer new
		          onCanvas: RSCanvas new
		          slotsBlock: [ :anObj | 
		          anObj instVarsNamesOrderedCollection ].
	^ canvas
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
	| canvas |
	canvas := self
		          treeDrawer: CTSlotsTopologicallySortedDfsTreeDrawer new
		          onCanvas: RSCanvas new
		          slotsBlock: [ :anObj | 
		          anObj instVarsNamesOrderedCollection ].
	^ canvas
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
		  varName -> [ :anObj | anObj instVarNamed: varName ] ]
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> treeDrawer: aDrawer onCanvas: aCanvas slotsBlock: aBlock [

	^ aDrawer
		  visit: (CTObjectRefsVisit new
				   rootObject: self;
				   slotsBlock: aBlock;
				   yourself);
		  drawOnCanvas: aCanvas
]

Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> drawCollapsedSCCsOfSlotsGraphOnCanvas: aCanvas slotsBlock: aBlock [

	^ CTSlotsCollapsedSCCsDfsTreeDrawer new
		  visit: (CTObjectRefsVisit new
				   rootObject: self;
				   slotsBlock: aBlock;
				   yourself);
		  drawOnCanvas: aCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> drawSCCsOfSlotsGraphOnCanvas: aCanvas slotsBlock: aBlock [

	^ CTSlotsSCCsDfsTreeDrawer new
		  visit: (CTObjectRefsVisit new
				   rootObject: self;
				   slotsBlock: aBlock;
				   yourself);
		  drawOnCanvas: aCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> drawSlotsGraphOnCanvas: aCanvas slotsBlock: aBlock [

	^ CTSlotsDfsTreeDrawer new
		  visit: (CTObjectRefsVisit new
				   rootObject: self;
				   slotsBlock: aBlock;
				   yourself);
		  drawOnCanvas: aCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> drawTopologicallySortedSlotsGraphOnCanvas: aCanvas slotsBlock: aBlock [

	^ CTSlotsTopologicallySortedDfsTreeDrawer new
		  visit: (CTObjectRefsVisit new
				   rootObject: self;
				   slotsBlock: aBlock;
				   yourself);
		  drawOnCanvas: aCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraph [

	<inspectorPresentationOrder: 30 title: 'Slots graph'>
	| canvas |
	canvas := self
		          drawSlotsGraphOnCanvas: RSCanvas new
		          slotsBlock: [ :anObj | 
		          anObj instVarsNamesOrderedCollection ].
	^ canvas
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraphCollapsedSCCs [

	<inspectorPresentationOrder: 60 title:
	'Collapsed SCCs of Slots graph'>
	| canvas |
	canvas := self
		          drawCollapsedSCCsOfSlotsGraphOnCanvas: RSCanvas new
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

	<inspectorPresentationOrder: 50 title: 'SCCs of Slots graph'>
	| canvas |
	canvas := self
		          drawSCCsOfSlotsGraphOnCanvas: RSCanvas new
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

	<inspectorPresentationOrder: 40 title: 'Slots graph, topologically sorted.'>
	| canvas |
	canvas := self
		          drawTopologicallySortedSlotsGraphOnCanvas: RSCanvas new
		          slotsBlock: [ :anObj | anObj instVarsNamesOrderedCollection ].
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

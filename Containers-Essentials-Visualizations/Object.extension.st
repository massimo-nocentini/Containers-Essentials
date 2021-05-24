Extension { #name : #Object }

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> drawCollapsedSCCsOfSlotsGraphOnCanvas: aCanvas referencesBlock: aBlock [

	^ CTSlotsCollapsedSCCsDfsTreeDrawer new
		  visit: (CTObjectRefsVisit new
				   rootObject: self;
				   yourself);
		  drawOnCanvas: aCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> drawSCCsOfSlotsGraphOnCanvas: aCanvas referencesBlock: aBlock [

	^ CTSlotsSCCsDfsTreeDrawer new
		  visit: (CTObjectRefsVisit new
				   rootObject: self;
				   yourself);
		  drawOnCanvas: aCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> drawSlotsGraphOnCanvas: aCanvas referencesBlock: _ [

	^ CTSlotsDfsTreeDrawer new
		  visit: (CTObjectRefsVisit new
				   rootObject: self;
				   yourself);
		  drawOnCanvas: aCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> drawTopologicallySortedSlotsGraphOnCanvas: aCanvas referencesBlock: aBlock [

	^ CTSlotsTopologicallySortedDfsTreeDrawer new
		  visit: (CTObjectRefsVisit new
				   rootObject: self;
				   yourself);
		  drawOnCanvas: aCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
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

{ #category : #'*Containers-Essentials-Visualizations' }
Object >> inspectorCanvasSlotsGraphCollapsedSCCs [

	<inspectorPresentationOrder: 60 title:
	'Collapsed SCCs of Slots graph'>
	| canvas |
	canvas := self
		          drawCollapsedSCCsOfSlotsGraphOnCanvas: RSCanvas new
		          referencesBlock: [ :anObj | 
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
		          referencesBlock: [ :anObj | 
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
		          referencesBlock: [ :anObj | anObj instVarsNamesOrderedCollection ].
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

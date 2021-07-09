Extension { #name : #Link }

{ #category : #'*Containers-Essentials-Visualizations' }
Link >> asShapeNestedSlotsDfsTree [

	^ self
		  asShapeTreeDrawer: CTSlotsDfsTreeDrawer new
		  slotsBlock: [ :anObj | anObj instVarsNamesOrderedCollectionNested ]
]

{ #category : #'*Containers-Essentials-Visualizations' }
Link >> inspectorCanvasNestedSlotsGraph [

	<inspectorPresentationOrder: 150 title: '(Nested) Slots graph'>
	^ RSCanvas new
		  add: self asShapeNestedSlotsDfsTree;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
Link >> instVarsNamesOrderedCollection [

	^ { #nextLink }
]

{ #category : #'*Containers-Essentials-Visualizations' }
Link >> instVarsNamesOrderedCollectionNested [

	^ { (#nextLink asSlotDescriptor
		   blockClosure: [ 
			   self nextLink
				   ifNil: [ nil asShapeSlotsDfsTree ]
				   ifNotNil: #asShapeNestedSlotsDfsTree ];
		   inline: true;
		   quote) }
]

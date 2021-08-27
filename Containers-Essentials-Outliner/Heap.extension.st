Extension { #name : #Heap }

{ #category : #'*Containers-Essentials-Outliner' }
Heap >> inspectorCanvasValuesTree [

	<inspectorPresentationOrder: 1010 title: 'Values tree'>
	^ RSCanvas new
		  add: self asShapeValuesHorizontalTree;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Outliner' }
Heap >> inspectorCanvasValuesTreeContext: aContext [

	aContext withoutEvaluator
]

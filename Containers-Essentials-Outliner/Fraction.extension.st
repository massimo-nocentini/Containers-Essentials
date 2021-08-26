Extension { #name : #Fraction }

{ #category : #'*Containers-Essentials-Outliner' }
Fraction >> inspectorCanvasFordCircles [

	<inspectorPresentationOrder: 1010 title: 'Ford circles'>
	^ RSCanvas new
		  add: self asShapeFordCircles;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Outliner' }
Fraction >> inspectorCanvasFordCirclesContext: aContext [

	aContext withoutEvaluator
]

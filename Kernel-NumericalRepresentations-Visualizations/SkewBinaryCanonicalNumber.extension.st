Extension { #name : #SkewBinaryCanonicalNumber }

{ #category : #'*Kernel-NumericalRepresentations-Visualizations' }
SkewBinaryCanonicalNumber >> gtInspectorRepresentationViewIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal3
		  title: 'Skew (dense)';
		  initializeCanvas: [ 
			  | aCanvas |
			  aCanvas := self gtInspectorSkewDenseRepresentationInCanvas:
					             RSCanvas new.
			  aCanvas @ RSCanvasController ];
		  yourself
]

{ #category : #'*Kernel-NumericalRepresentations-Visualizations' }
SkewBinaryCanonicalNumber >> gtInspectorSkewDenseRepresentationInCanvas: aCanvas [
	^ aCanvas
		  addAll: (representation ifNil: [ 0 ~~> nil ]) asValueLinksGroup;
		  yourself
]

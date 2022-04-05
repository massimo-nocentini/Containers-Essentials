Extension { #name : #RBProgramNode }

{ #category : #'*Containers-Essentials-Outliner' }
RBProgramNode >> inspectorRoassalTree [

	<inspectorPresentationOrder: 1010 title: 'Roassal Tree'>
	| shapes edges indexes associations doubleGR emptySpaceWidth prototypeLabelShape |
	doubleGR := Float goldenRatio double.
	indexes := IdentityDictionary new.
	associations := OrderedCollection new.

	prototypeLabelShape := RSLabel new
		                       fontName: 'Source Code Pro';
		                       yourself.

	emptySpaceWidth := (prototypeLabelShape copy text:
		                    Character tab asString) computeTextExtents width.

	shapes := IdentityDictionary new.

	self nodesDo: [ :each | 
		| valueShape classLabel box |
		classLabel := RSLabel new
			              model: each class;
			              italic;
			              yourself.

		valueShape := (each formattedCode asShapeMultilineLabel:
				               prototypeLabelShape)
			              padding: doubleGR;
			              yourself.

		box := RSBox new
			       color: Color white;
			       withBorder;
			       cornerRadius: doubleGR;
			       extent: (classLabel extent max: valueShape extent);
			       yourself.

		RSLocation new
			left;
			stick: valueShape on: box.

		box := RSComposite new
			       shapes: { 
					       box.
					       valueShape };
			       yourself.

		RSLocation new above stick: classLabel on: box.

		RSAlignment new
			shapes: { 
					classLabel.
					box };
			left.

		RSComposite new
			model: each;
			addShape: classLabel;
			addShape: box;
			adjustToChildren;
			padding: doubleGR;
			draggable;
			yourself: [ :mineShape | 
				shapes at: each put: mineShape.
				each parent ifNotNil: [ :myParent | 
						shapes
							at: myParent
							ifPresent: [ :parentShape | 
								associations add: parentShape -> mineShape ] ] ] ].

	edges := RSEdgeBuilder horizontalBezier withHorizontalAttachPoint 
		         in: [ :eb | 
			         associations collect: [ :eachAssoc | 
				         eb edgeFrom: eachAssoc key to: eachAssoc value ] ].

	RSHorizontalVanDerPloegTreeLayout new
		doNotValidateCycles;
		on: shapes values edges: edges.

	^ RSCanvas new
		  addAll: shapes values;
		  addAll: edges;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Outliner' }
RBProgramNode >> inspectorRoassalTreeContext: aContext [

	aContext withoutEvaluator
]

Extension { #name : #RBProgramNode }

{ #category : #'*Containers-Essentials-Visualizations' }
RBProgramNode >> inspectorRoassalTree [

	<inspectorPresentationOrder: 100 title: 'Roassal Tree'>
	| shapes edges indexes associations doubleGR emptySpaceWidth |
	doubleGR := Float goldenRatio double.
	indexes := IdentityDictionary new.
	associations := OrderedCollection new.
	emptySpaceWidth := (RSLabel new
		                    text: Character tab asString;
		                    fontName: 'Source Code Pro';
		                    yourself) computeTextExtents width.

	shapes := IdentityDictionary new.

	self nodesDo: [ :each | 
		| valueShape classLabel labels box |
		classLabel := RSLabel new
			              model: each class;
			              italic;
			              yourself.

		labels := each formattedCode lines collect: [ :eachLine | 
			          | s |
			          s := 1.
			          [ 
			          s < eachLine size and: [ (eachLine at: s) isSeparator ] ] 
				          whileTrue: [ s := s + 1 ].
			          RSLabel new
				          text: (eachLine trim ifEmpty: [ ' ' ]);
				          fontName: 'Source Code Pro';
				          propertyAt: #leftSpaces put: s - 1;
				          yourself ].

		each class == RBMethodNode ifTrue: [ labels first bold ].

		RSVerticalLineLayout new
			alignLeft;
			gapSize: 0;
			on: { classLabel } , labels.

		labels do: [ :eachLabel | 
			| x |
			x := (eachLabel propertyAt: #leftSpaces) * emptySpaceWidth
			     + eachLabel position x.
			eachLabel position: x @ eachLabel position y ].

		valueShape := RSComposite new
			              shapes: labels;
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
		  addInteraction: RSCanvasControllerInteraction new;
		  inspectorCanvas
]

{ #category : #'*Containers-Essentials-Visualizations' }
RBProgramNode >> inspectorRoassalTreeContext: aContext [

	aContext withoutEvaluator
]

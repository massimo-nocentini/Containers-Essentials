Extension { #name : 'String' }

{ #category : '*Containers-Essentials-Visualizations' }
String >> asShapeMultilineLabel: aPrototypeLabelShape [

	| emptySpaceWidth labels |
	emptySpaceWidth := (aPrototypeLabelShape copy
		                    text: Character tab asString;
		                    yourself) computeTextExtents width.

	labels := self lines collect: [ :eachLine | 
		          | s string |
		          s := (eachLine copyReplaceAll: String tab with: '  ') 
			               largestIndexUntil: [ :aCharacter | 
			               aCharacter isSeparator ].
		          string := eachLine trim ifEmpty: [ ' ' ].
		          aPrototypeLabelShape copy
			          text: string;
			          propertyAt: #leftSpaces put: s;
			          yourself ].

	RSVerticalLineLayout new
		alignLeft;
		verticalGap: 0;
		on: labels.

	labels do: [ :eachLabel | 
		| x |
		x := (eachLabel propertyAt: #leftSpaces) * emptySpaceWidth
		     + eachLabel position x.

		eachLabel
			position: x @ eachLabel position y;
			removePropertyAt: #leftSpaces ].

	^ RSComposite new
		  shapes: labels;
		  yourself
]

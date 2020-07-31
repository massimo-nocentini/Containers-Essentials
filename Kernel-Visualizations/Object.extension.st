Extension { #name : #Object }

{ #category : #'*Kernel-Visualizations' }
Object >> asSlotsShape [
	^ self asSlotsShapeKnownReferences: IdentitySet empty
]

{ #category : #'*Kernel-Visualizations' }
Object >> asSlotsShapeKnownReferences: aSet [
	| group shapes rectangle instVars cornerRadious |
	cornerRadious := 5.
	instVars := self class allInstVarNames.
	shapes := instVars collect: [ :var | 
		          | value |
		          value := self instVarNamed: var.
		          (aSet includes: value)
			          ifTrue: [ nil ]
			          ifFalse: [ 
				          RSLabel new
					          text: value;
					          yourself ] ].
	rectangle := shapes
		             inject: Rectangle emptyAtOrigin
		             into: [ :aRectangle :aShape | 
			             aRectangle encompass:
				             (aShape ifNil: [ aRectangle extent ] ifNotNil: [ 
					              | textExtent |
					              textExtent := aShape textExtents.
					              textExtent width @ textExtent height ]) ].
	group := instVars withIndexCollect: [ :var :index | 
		         | value label box aShape |
		         aShape := shapes at: index.
		         value := self instVarNamed: var.
		         label := RSLabel new
			                  model: var;
			                  text: var;
			                  color: Color gray;
			                  yourself.
		         box := RSBox new
			                model: value;
			                color: Color white;
			                height: rectangle height + 5;
			                width:
				                ((aShape ifNil: [ 0 ] ifNotNil: [ aShape width ]) 
					                 max: label width) + 5;
			                withBorder.

		         "Handle corners correctly."
		         box cornerRadius: (index = 1
				          ifTrue: [ RSCornerRadius new left: cornerRadious ]
				          ifFalse: [ 
					          index = instVars size
						          ifTrue: [ RSCornerRadius new right: cornerRadious ]
						          ifFalse: [ RSCornerRadius new ] ]).
		         box := aShape
			                ifNil: [ 
				                RSComposite new
					                shapes: { box };
					                yourself ]
			                ifNotNil: [ 
				                RSLocation new
					                inner;
					                move: aShape on: box.
				                RSComposite new
					                shapes: { 
							                box.
							                aShape };
					                yourself ].
		         box padding: 0 @ 1.
		         RSLocation new
			         above;
			         move: label on: box.
		         RSComposite new
			         model: var -> value;
			         shapes: { 
					         box.
					         label };
			         yourself ].
	RSHorizontalLineLayout new
		horizontalGap: 0;
		on: group.
	RSAlignment new
		shapes: group;
		bottom.
	^ (RSGroup new
		   add: (RSComposite new
				    shapes: group;
				    yourself);
		   yourself) @ RSDraggable
]

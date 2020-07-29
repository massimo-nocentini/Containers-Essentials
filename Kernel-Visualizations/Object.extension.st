Extension { #name : #Object }

{ #category : #'*Kernel-Visualizations' }
Object >> asSlotsShape [
	| group shapes rectangle instVars cornerRadious |
	cornerRadious := 5.
	instVars := self class allInstVarNames.
	shapes := instVars collect: [ :var | 
		          | value |
		          value := self instVarNamed: var.
		          value isLiteral
			          ifTrue: [ 
				          RSLabel new
					          model: value;
					          text: value;
					          yourself ]
			          ifFalse: [ nil ] ].
	rectangle := shapes
		             inject: (Rectangle origin: 0 asPoint extent: 0 asPoint)
		             into: [ :aRectangle :aShape | 
			             aRectangle encompass:
				             (aShape ifNil: [ aRectangle extent ] ifNotNil: [ 
					              | textExtent |
					              textExtent := aShape textExtents.
					              textExtent width @ textExtent height ]) ].
	group := (instVars withIndexCollect: [ :var :index | 
		          | value label box |
		          value := self instVarNamed: var.
		          label := RSLabel new
			                   model: var;
			                   text: var;
			                   color: Color gray;
			                   yourself.
		          box := RSBox new
			                 color: Color white;
			                 height: rectangle height + 5;
			                 width: (rectangle width max: label textWidth) + 5;
			                 withBorder;
			                 model: value.
		          index = 1
			          ifTrue: [ 
			          box cornerRadius:
				          (RSCornerRadius new left: cornerRadious) ]
			          ifFalse: [ 
				          index = instVars size ifTrue: [ 
					          box cornerRadius:
						          (RSCornerRadius new right: cornerRadious) ] ].
		          box := (shapes at: index)
			                 ifNil: [ 
				                 RSComposite new
					                 model: box model;
					                 shapes: { box };
					                 yourself ]
			                 ifNotNil: [ :aShape | 
				                 RSLocation new
					                 inner;
					                 move: aShape on: box.
				                 RSComposite new
					                 model: aShape model;
					                 shapes: { 
							                 box.
							                 aShape };
					                 yourself ].
		          box padding: 0 @ 1.
		          RSLocation new
			          above;
			          move: label on: box.
		          (RSComposite new
			           model: value;
			           shapes: { 
					           box.
					           label };
			           yourself)  ]) .
	RSHorizontalLineLayout new
		horizontalGap: 0;
		on: group.
"	^ group asShapeFor: self"
	^ (RSComposite new shapes: group;yourself) @ RSDraggable
]

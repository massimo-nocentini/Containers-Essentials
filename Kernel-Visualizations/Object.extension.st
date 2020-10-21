Extension { #name : #Object }

{ #category : #'*Kernel-Visualizations' }
Object >> asSlotsShapeKnownReferences: aSet [
	^ self
		  asSlotsShapeKnownReferences: aSet
		  accessors: self instVarsNamesOrderedCollection
]

{ #category : #'*Kernel-Visualizations' }
Object >> asSlotsShapeKnownReferences: aSet accessors: selectors [
	| shapes rectangle radious descriptors aGroup |
	"Basic settings for rounding the boxes"
	radious := 2.

	"Build label shapes for objects not known according to the `aSet` argument."
	descriptors := selectors collect: [ :anAssociation | 
		               | value shape var accessor |
		               var := anAssociation key.
		               accessor := anAssociation value.
		               value := accessor value: self.
		               shape := (aSet includes: value)
			                        ifTrue: [ nil ]
			                        ifFalse: [ "Don't set the model because it will be attached to the enclosing box."
				                        RSLabel new
					                        text: (value ifNil: [ 'nil' ]);
					                        yourself ].

		               "Our descriptor is a plain dictionary."
		               Dictionary new
			               at: #var put: var;
			               at: #value put: value;
			               at: #shape put: shape;
			               yourself ].

	"Compute a rectangle to share the same dimensions."
	rectangle := descriptors
		             inject: (Rectangle emptyAtOrigin withHeight: 15)
		             into: [ :aRectangle :slotDescriptor | 
			             | aShapeOrNil |
			             aShapeOrNil := slotDescriptor at: #shape.
			             aRectangle encompass:
				             (aShapeOrNil
					              ifNil: [ aRectangle extent ]
					              ifNotNil: [ 
						              | textExtent |
						              textExtent := aShapeOrNil textExtents.
						              textExtent width @ textExtent height ]) ].
	shapes := descriptors withIndexCollect: [ :slotDescriptor :index | 
		          | var value label box aShape cornerRadious |
		          "Unpacking."
		          var := slotDescriptor at: #var.
		          value := slotDescriptor at: #value.
		          aShape := slotDescriptor at: #shape.
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
		          cornerRadious := RSCornerRadius new.
		          index = 1 ifTrue: [ cornerRadious left: radious ].
		          index = selectors size ifTrue: [ 
			          cornerRadious right: radious ].
		          box cornerRadius: cornerRadious.
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
			          shapes: { 
					          box.
					          label };
			          yourself ].
	RSHorizontalLineLayout new
		horizontalGap: 0;
		on: shapes.
	RSAlignment new
		shapes: shapes;
		bottom.
	aGroup := RSGroup new
		          add: (RSComposite new
				           shapes: shapes;
				           yourself);
		          yourself.
	"	aGroup @ (RSPopup text: self class)."
	^ aGroup
]

{ #category : #'*Kernel-Visualizations' }
Object >> gtInspectorSlotsGraphIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite roassal3
		  title: 'Slots graph';
		  initializeCanvas: [ 
			  | aGroup |
			  aGroup := self asSlotsShapeKnownReferences: IdentitySet empty.
			  (RSCanvas new
				   addAll: aGroup;
				   yourself) @ RSCanvasController ];
		  yourself
]

{ #category : #'*Kernel-Visualizations' }
Object >> instVarsNamesOrderedCollection [
	^ self class allInstVarNames collect: [ :varName | 
		  varName -> [ :anObj | anObj instVarNamed: varName ] ]
]

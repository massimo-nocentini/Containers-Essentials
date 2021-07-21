Extension { #name : #Behavior }

{ #category : #'*Containers-Essentials-Visualizations' }
Behavior >> asShapeAllSuperclassesIndented: shapeBlock [

	| superClassShapes |
	superClassShapes := self allSuperclasses reversed , { self } 
		                    collect: shapeBlock.

	RSVerticalLineLayout new
		verticalGap: Float goldenRatio negated;
		alignLeft;
		on: superClassShapes.

	superClassShapes withIndexDo: [ :aShape :times | 
		| offset |
		offset := Float goldenRatio double * times.
		aShape position: aShape position x + offset @ aShape position y ].

	^ RSComposite new
		  model: self;
		  shapes: superClassShapes;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Behavior >> asShapeSubclasses [

	| gr commits edges |
	gr := Float goldenRatio.
	commits := Array streamContents: [ :aStream | 
		           self withAllSubclassesDo: [ :aSubClass | 
			           | label box |
			           label := RSLabel new text: aSubClass name.
			           aSubClass isAbstract ifTrue: [ 
				           label
					           bold;
					           italic ].
			           box := RSBox new
				                  color: Color white;
				                  withBorder;
				                  cornerRadius: gr * 2;
				                  extent: label extent + (gr * 4) asPoint;
				                  yourself.
			           RSLocation new center stick: label on: box.
			           aStream nextPut: (RSComposite new
					            model: aSubClass;
					            shapes: (Array with: box with: label);
					            draggable;
					            when: RSMouseLeftClick
					            do: [ :ev | aSubClass browse ];
					            yourself) ] ].

	edges := RSLineBuilder horizontalBezier
		         shapes: commits;
		         withHorizontalAttachPoint;
		         connectToAll: [ :aSubClass | aSubClass subclasses ].

	edges sort: [ :a :b | 
		| aName bName |
		aName := a from model name.
		bName := b from model name.
		aName = bName
			ifTrue: [ a to model name < b to model name ]
			ifFalse: [ aName < bName ] ].

	RSHorizontalVanDerPloegTreeLayout new
		doNotValidateCycles;
		on: commits edges: edges.

	^ RSComposite new
		  shapes: commits , edges;
		  yourself
]

{ #category : #'*Containers-Essentials-Visualizations' }
Behavior >> instVarsNamesOrderedCollection [

	^ { 
		  (#name asSlotDescriptor inline: true).
		  #class asSlotDescriptor.
		  #superclass asSlotDescriptor.
		  #typeOfClass asSlotDescriptor.
		  #instanceCount asSlotDescriptor
		  "#spaceUsed asSlotDescriptor.
		  #kindAsSymbol asSlotDescriptor" }
]

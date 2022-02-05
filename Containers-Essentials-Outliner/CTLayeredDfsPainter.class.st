"
I am a variant that group outline shapes if they are equally far from the root outliner.
"
Class {
	#name : #CTLayeredDfsPainter,
	#superclass : #CTDfsPainter,
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #DFS }
CTLayeredDfsPainter >> dfsWalk: anObject [

	| gr location layout aCollection |
	aCollection := super dfsWalk: anObject.

	gr := Float goldenRatio double.
	location := RSLocation new center.
	layout := RSVerticalLineLayout new
		          alignCenter;
		          yourself.

	^ levels keys sorted collect: [ :level | 
		  | layer composite box label |
		  layer := levels at: level.

		  layer do: [ :each | each removeInteractionIfPresent: RSDraggable ].

		  layout on: layer.

		  label := RSLabel new
			           text: (String streamContents: [ :aStream | 
						            aStream
							            nextPutAll: 'Level ';
							            nextPutAll: level asString;
							            nextPutAll: ' with ';
							            nextPutAll: layer size asString;
							            nextPutAll: ' objects' ]);
			           bold;
			           yourself.

		  composite := RSComposite new
			               shapes: layer;
			               padding: gr;
			               yourself.

		  box := RSBox new
			         model: layer;
			         extent: (composite extent max: label extent);
			         color: Color white;
			         withBorder;
			         cornerRadius: gr;
			         yourself.

		  location
			  stick: composite on: box;
			  above;
			  stick: label on: box;
			  inner.

		  RSComposite new
			  shapes: (Array with: label with: box with: composite);
			  draggable;
			  yourself ]
]

{ #category : #layouting }
CTLayeredDfsPainter >> layoutOn: aCollectionOfShapes edges: aCollectionOfLines [

	RSHorizontalLineLayout new alignMiddle applyOn: aCollectionOfShapes
]

{ #category : #'line drawing' }
CTLayeredDfsPainter >> layoutTuples: treeTuples lineBuilder: lineBuilder [

	^ #(  )
]

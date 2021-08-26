Class {
	#name : #CTLayeredDfsVisitPainter,
	#superclass : #CTDfsVisitPainter,
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #'as yet unclassified' }
CTLayeredDfsVisitPainter >> layoutOn: aCollectionOfShapes edges: aCollectionOfLines [

	RSHorizontalLineLayout new alignMiddle applyOn: aCollectionOfShapes
]

{ #category : #'as yet unclassified' }
CTLayeredDfsVisitPainter >> layoutTuples: treeTuples lineBuilder: lineBuilder [

	^ #(  )
]

{ #category : #adding }
CTLayeredDfsVisitPainter >> shapes: aCollection [

	| levelShapes gr location layout |
	gr := Float goldenRatio double.
	location := RSLocation new center.
	layout := RSVerticalLineLayout new
		          alignCenter;
		          yourself.

	levelShapes := levels keys sorted collect: [ :level | 
		               | layer composite box label |
		               layer := levels at: level.

		               layer do: [ :each | 
			               each removeInteractionIfPresent: RSDraggable ].

		               layout on: layer.

		               label := RSLabel new
			                        text:
				                        (String streamContents: [ :aStream | 
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
			               shapes:
				               (Array with: label with: box with: composite);
			               draggable;
			               yourself ].

	^ super shapes: levelShapes
]

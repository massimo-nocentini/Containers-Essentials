"
I am a variant that layout the outline shapes in a vertical line acording to the topological order among them.
"
Class {
	#name : #CTTopologicalSortDfsPainter,
	#superclass : #CTDfsPainter,
	#category : #'Containers-Essentials-Outliner'
}

{ #category : #'as yet unclassified' }
CTTopologicalSortDfsPainter >> backLinesBuilder [

	| color |
	color := Color gray lighter lighter lighter.
	^ RSLineBuilder bezier
		  markerEnd: (RSMarker new
				   shape: (RSShapeFactory arrow
						    size: Float goldenRatio * 5;
						    color: color;
						    cornerRadii: Float goldenRatio;
						    yourself);
				   offset: Float goldenRatio double;
				   yourself);
		  color: color;
		  dotted;
		  controlPointsController: (RSStartEndCPAPController new
				   controller: RSDirectedBezierConcavityCPAPController new;
				   startAttachPoint: RSCenteredAttachPoint new;
				   endAttachPoint: RSBottomEndVerticalAttachPoint new);
		  yourself
]

{ #category : #'as yet unclassified' }
CTTopologicalSortDfsPainter >> crossLinesBuilder [

	| color |
	color := Color gray lighter lighter lighter.
	^ RSLineBuilder bezier
		  markerEnd: (RSMarker new
				   shape: (RSShapeFactory arrow
						    size: Float goldenRatio * 5;
						    color: color;
						    cornerRadii: Float goldenRatio;
						    yourself);
				   offset: Float goldenRatio double;
				   yourself);
		  color: color;
		  dashed;
		  controlPointsController: (RSStartEndCPAPController new
				   controller: RSDirectedBezierConcavityCPAPController new;
				   startAttachPoint: RSCenteredAttachPoint new;
				   endAttachPoint: RSVerticalAttachPoint new);
		  yourself
]

{ #category : #adding }
CTTopologicalSortDfsPainter >> dfsWalk [

	^ super dfsWalk sorted: [ :aShape :anotherShape | 
		  aShape propertyDfsLeaveTime > anotherShape propertyDfsLeaveTime ]
]

{ #category : #'as yet unclassified' }
CTTopologicalSortDfsPainter >> forwardLinesBuilder [

	| color |
	color := Color gray lighter lighter lighter.
	^ RSLineBuilder bezier
		  markerEnd: (RSMarker new
				   shape: (RSShapeFactory arrow
						    size: Float goldenRatio * 5;
						    color: color;
						    cornerRadii: Float goldenRatio;
						    yourself);
				   offset: Float goldenRatio double;
				   yourself);
		  color: color;
		  controlPointsController: (RSStartEndCPAPController new
				   controller: RSDirectedBezierConcavityCPAPController new;
				   startAttachPoint: RSCenteredAttachPoint new;
				   endAttachPoint: RSVerticalAttachPoint new);
		  yourself
]

{ #category : #'as yet unclassified' }
CTTopologicalSortDfsPainter >> layoutOn: aCollectionOfShapes edges: aCollectionOfLines [

	RSVerticalLineLayout new
		alignCenter;
		applyOn: aCollectionOfShapes
]

{ #category : #'as yet unclassified' }
CTTopologicalSortDfsPainter >> layoutTuples: treeTuples lineBuilder: lineBuilder [

	^ Array empty
]

{ #category : #'as yet unclassified' }
CTTopologicalSortDfsPainter >> treeLinesBuilder [

	| color |
	color := Color gray lighter lighter lighter.
	^ RSLineBuilder bezier
		  markerEnd: (RSMarker new
				   shape: (RSShapeFactory arrow
						    size: Float goldenRatio * 5;
						    color: color;
						    cornerRadii: Float goldenRatio;
						    yourself);
				   offset: Float goldenRatio double;
				   yourself);
		  color: color;
		  controlPointsController: (RSStartEndCPAPController new
				   controller: RSDirectedBezierConcavityCPAPController new;
				   startAttachPoint: RSCenteredAttachPoint new;
				   endAttachPoint: RSVerticalAttachPoint new);
		  yourself
]

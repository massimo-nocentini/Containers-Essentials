"
I am a variant that layout the outline shapes in a vertical line acording to the topological order among them.
"
Class {
	#name : 'CTTopologicalSortDfsPainter',
	#superclass : 'CTDfsPainter',
	#category : 'Containers-Essentials-Outliner-Painters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Painters'
}

{ #category : 'line building' }
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

{ #category : 'line building' }
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

{ #category : 'DFS' }
CTTopologicalSortDfsPainter >> dfsWalk: anObject [

	^ (super dfsWalk: anObject) sorted: [ :aShape :anotherShape | 
		  aShape propertyDfsLeaveTime > anotherShape propertyDfsLeaveTime ]
]

{ #category : 'line building' }
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

{ #category : 'layouting' }
CTTopologicalSortDfsPainter >> layoutOn: aCollectionOfShapes edges: aCollectionOfLines [

	RSVerticalLineLayout new
		alignCenter;
		applyOn: aCollectionOfShapes
]

{ #category : 'line drawing' }
CTTopologicalSortDfsPainter >> layoutTuples: treeTuples lineBuilder: lineBuilder [

	^ {  }
]

{ #category : 'line building' }
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

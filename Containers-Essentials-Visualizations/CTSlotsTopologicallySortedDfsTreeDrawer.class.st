Class {
	#name : #CTSlotsTopologicallySortedDfsTreeDrawer,
	#superclass : #CTSlotsDfsTreeDrawer,
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #adding }
CTSlotsTopologicallySortedDfsTreeDrawer >> addAll: shapes onCanvas: aCanvas [

	| sortedShapes |
	sortedShapes := shapes sorted: [ :aShape :anotherShape | 
		                aShape propertyDfsLeaveTime
		                > anotherShape propertyDfsLeaveTime ].

	^ super addAll: sortedShapes onCanvas: aCanvas
]

{ #category : #'as yet unclassified' }
CTSlotsTopologicallySortedDfsTreeDrawer >> cpapControllerHorizontal [

	^ self cpapControllerBezierDirected
]

{ #category : #'as yet unclassified' }
CTSlotsTopologicallySortedDfsTreeDrawer >> layoutOn: shapes edges: edges [

	RSVerticalLineLayout new alignCenter applyOn: shapes
]

{ #category : #'as yet unclassified' }
CTSlotsTopologicallySortedDfsTreeDrawer >> layoutTuples: treeTuples lineBuilder: lineBuilder [

	^ #(  )
]

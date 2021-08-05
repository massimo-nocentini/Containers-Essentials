Class {
	#name : #CTSlotsTopologicallySortedDfsTreeDrawer,
	#superclass : #CTSlotsDfsTreeDrawer,
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #'as yet unclassified' }
CTSlotsTopologicallySortedDfsTreeDrawer >> layoutOn: aCollectionOfShapes edges: aCollectionOfLines [

	RSVerticalLineLayout new alignCenter applyOn: aCollectionOfShapes
]

{ #category : #'as yet unclassified' }
CTSlotsTopologicallySortedDfsTreeDrawer >> layoutTuples: treeTuples lineBuilder: lineBuilder [

	^ #(  )
]

{ #category : #adding }
CTSlotsTopologicallySortedDfsTreeDrawer >> shapes: aCollection [

	| sortedShapes |
	sortedShapes := aCollection sorted: [ :aShape :anotherShape | 
		                aShape propertyDfsLeaveTime
		                > anotherShape propertyDfsLeaveTime ].

	^ super shapes: sortedShapes
]

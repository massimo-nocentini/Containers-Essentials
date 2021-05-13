Class {
	#name : #CTSlotsDrawer,
	#superclass : #Object,
	#instVars : [
		'visit'
	],
	#category : #'Containers-Essentials-Visualizations'
}

{ #category : #'*Containers-Essentials-Visualizations' }
CTSlotsDrawer >> bezierShape [

	| controller |
	controller := RSStartEndCPAPController new
		              controller: RSDirectedBezierCPAPController new;
		              startAttachPoint: RSCenteredAttachPoint new;
		              endAttachPoint: RSBorderAttachPoint new;
		              yourself.
	^ RSBezier new
		  controlPointsController: controller;
		  yourself
]

{ #category : #'as yet unclassified' }
CTSlotsDrawer >> drawOnCanvas: aCanvas [

	self subclassResponsibility
]

{ #category : #accessing }
CTSlotsDrawer >> visit: anObject [

	visit := anObject
]
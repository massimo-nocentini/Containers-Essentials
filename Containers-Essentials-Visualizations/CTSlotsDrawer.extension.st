Extension { #name : #CTSlotsDrawer }

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

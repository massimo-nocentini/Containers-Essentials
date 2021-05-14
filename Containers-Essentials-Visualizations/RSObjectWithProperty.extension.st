Extension { #name : #RSObjectWithProperty }

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsBoxedSlotsShape [

	^ self propertyAt: #boxedSlotsShape
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsDepth [

	^ self propertyAt: #bfsLevel
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsDepth: anObject [

	^ self propertyAt: #bfsLevel put: anObject
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsEntryTime [

	^ (self propertyAt: #dfsTimings) x
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsLeaveTime [

	^ (self propertyAt: #dfsTimings) y
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsLowlink [

	^ self propertyAt: #sccLowlink
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsLowlink: anObject [

	^ self propertyAt: #sccLowlink put: anObject
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsSCC [

	^ self propertyAt: #scc
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsTimings [

	^ self propertyAt: #dfsTimings
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsTimings: aPoint [

	^ self propertyAt: #dfsTimings put: aPoint
]

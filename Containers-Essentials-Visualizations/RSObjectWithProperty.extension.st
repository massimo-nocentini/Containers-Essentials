Extension { #name : #RSObjectWithProperty }

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsDepth [

	^ self propertyAt: #bfsLevel
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
RSObjectWithProperty >> propertyDfsTimings [

	^ self propertyAt: #dfsTimings
]

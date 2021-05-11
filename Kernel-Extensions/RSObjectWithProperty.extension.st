Extension { #name : #RSObjectWithProperty }

{ #category : #'*Kernel-Extensions' }
RSObjectWithProperty >> propertyDfsDepth [

	^ self propertyAt: #bfsLevel
]

{ #category : #'*Kernel-Extensions' }
RSObjectWithProperty >> propertyDfsEntryTime [

	^ (self propertyAt: #dfsTimings) x
]

{ #category : #'*Kernel-Extensions' }
RSObjectWithProperty >> propertyDfsLeaveTime [

	^ (self propertyAt: #dfsTimings) y
]

{ #category : #'*Kernel-Extensions' }
RSObjectWithProperty >> propertyDfsTimings [

	^ self propertyAt: #dfsTimings
]

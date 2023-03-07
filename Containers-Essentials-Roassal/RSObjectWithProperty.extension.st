Extension { #name : #RSObjectWithProperty }

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsBCC [

	^ self propertyAt: #bcc
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsBCC: aCollection [

	^ self propertyAt: #bcc put: aCollection
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsBilink [

	^ self propertyAt: #sccBilink
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsBoxedSlotsShape [

	^ self propertyAt: #boxedSlotsShape
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsBoxedSlotsShape: aShape [

	^ self propertyAt: #boxedSlotsShape put: aShape
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsDepth [

	^ self propertyAt: #dfsLevel
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsDepth: anObject [

	^ self propertyAt: #dfsLevel put: anObject
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsEntryTime [

	^ (self propertyAt: #dfsTimings) x
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsIsOnObjectStack [

	^ (self propertyAt: #dfsObjectStack ifAbsent: [ nil ])
		  ifNil: [ false ]
		  ifNotNil: [ true ]
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsLeaveTime [

	^ (self propertyAt: #dfsTimings) y
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsLowlink [

	^ self propertyAt: #sccLowlink
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsLowlink: anObject [

	^ self propertyAt: #sccLowlink put: anObject
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsLowlinkUpdate: aBlock [

	^ self propertyDfsLowlink: (aBlock value: self propertyDfsLowlink)
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsObjectStack: aStack [

	^ self propertyAt: #dfsObjectStack put: aStack
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsSCC [

	^ self propertyAt: #scc
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsSCC: aCollection [

	^ self propertyAt: #scc put: aCollection
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsTimings [

	^ self propertyAt: #dfsTimings
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsTimings: aPoint [

	^ self propertyAt: #dfsTimings put: aPoint
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsWalkingData [

	^ self propertyAt: #dfsWalkingData
]

{ #category : #'*Containers-Essentials-Roassal' }
RSObjectWithProperty >> propertyDfsWalkingData: anObject [

	^ self propertyAt: #dfsWalkingData put: anObject
]

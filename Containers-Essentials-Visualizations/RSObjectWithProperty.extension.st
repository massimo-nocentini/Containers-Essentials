Extension { #name : #RSObjectWithProperty }

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsBCC [

	^ self propertyAt: #bcc
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsBCC: aCollection [

	^ self propertyAt: #bcc put: aCollection
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsBilink [

	^ self propertyAt: #sccBilink
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsBilink: anObject [

	^ self propertyAt: #sccBilink put: anObject
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsBilinkUpdate: aBlock [

	^ self propertyDfsBilink: (aBlock value: self propertyDfsBilink)
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsBoxedSlotsShape [

	^ self propertyAt: #boxedSlotsShape
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsBoxedSlotsShape: aShape [

	^ self propertyAt: #boxedSlotsShape put: aShape
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
RSObjectWithProperty >> propertyDfsIsOnObjectStack [

	^ (self propertyAt: #dfsObjectStack ifAbsent: [ nil ])
		  ifNil: [ false ]
		  ifNotNil: [ true ]
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
RSObjectWithProperty >> propertyDfsLowlinkUpdate: aBlock [

	^ self propertyDfsLowlink: (aBlock value: self propertyDfsLowlink)
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsObjectStack: aStack [

	^ self propertyAt: #dfsObjectStack put: aStack
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsSCC [

	^ self propertyAt: #scc
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsSCC: aCollection [

	^ self propertyAt: #scc put: aCollection
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsTimings [

	^ self propertyAt: #dfsTimings
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyDfsTimings: aPoint [

	^ self propertyAt: #dfsTimings put: aPoint
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyIsArticulationObject [

	^ self propertyAt: #isArticulationObject ifAbsent: [ false ]
]

{ #category : #'*Containers-Essentials-Visualizations' }
RSObjectWithProperty >> propertyIsArticulationObject: aBoolean [

	^ self propertyAt: #isArticulationObject put: aBoolean
]

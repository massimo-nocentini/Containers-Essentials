Extension { #name : #Boolean }

{ #category : #'*Containers-Essentials-Visualizations' }
Boolean >> inlineFromSlotDescriptor: aSlotDescriptor [

	^ aSlotDescriptor inlineBoolean: self
]

Extension { #name : #Boolean }

{ #category : #'*Containers-Essentials-Outliner' }
Boolean >> inlineFromSlotDescriptor: aSlotDescriptor [

	^ aSlotDescriptor inlineBoolean: self
]

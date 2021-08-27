Extension { #name : #DateAndTime }

{ #category : #'*Containers-Essentials-Visualizations' }
DateAndTime >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitDateAndTime: self
]

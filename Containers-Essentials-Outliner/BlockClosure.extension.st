Extension { #name : #BlockClosure }

{ #category : #'*Containers-Essentials-Outliner' }
BlockClosure >> inlineFromSlotDescriptor: aSlotDescriptor [

	^ aSlotDescriptor inlineBlockClosure: self
]

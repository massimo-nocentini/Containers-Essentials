Extension { #name : #String }

{ #category : #'*Containers-Essentials-Outliner' }
String >> asSlotDescriptor [

	^ CTBlockSlotDescriptor new
		  selector: self;
		  yourself
]

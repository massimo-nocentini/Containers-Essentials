Extension { #name : #String }

{ #category : #'*Containers-Essentials-Visualizations' }
String >> onBox: boxShape setSizeFrom: aCharacter [

	^ boxShape
		  size: aCharacter asciiValue;
		  yourself
]

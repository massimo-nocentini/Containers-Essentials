Extension { #name : #String }

{ #category : #'*Collections-Abstract-Visualizations' }
String >> onBox: boxShape setSizeFrom: aCharacter [

	^ boxShape
		  size: aCharacter asciiValue;
		  yourself
]

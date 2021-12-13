Extension { #name : #RSLabel }

{ #category : #'*Containers-Essentials-Roassal' }
RSLabel class >> defaultCodeFont [

	^ StandardFonts codeFont
]

{ #category : #'*Containers-Essentials-Roassal' }
RSLabel >> fontSizeSilverRatio [

	self fontSize: self fontSize * Float silverRatio
]

{ #category : #'*Containers-Essentials-Roassal' }
RSLabel >> useCodeFont [

	self font: self class defaultCodeFont
]

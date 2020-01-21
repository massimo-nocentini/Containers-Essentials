Extension { #name : #RTView }

{ #category : #'*Roassal2-Core-Extensions' }
RTView >> exportPNGtoFilename: aFilename [
	RTPNGExporter new
		builder: self;
		withScale;
		fileName: aFilename;
		exportToFile
]

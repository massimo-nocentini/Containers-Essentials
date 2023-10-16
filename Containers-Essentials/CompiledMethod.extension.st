Extension { #name : 'CompiledMethod' }

{ #category : '*Containers-Essentials' }
CompiledMethod >> allImplementations [

	^ Array streamContents: [ :aStream | 
		  self methodClass withAllSubclassesDo: [ :aClass | 
			  | cm |
			  cm := [ aClass >> self selector ]
				        on: KeyNotFound
				        do: [ nil ].

			  cm ifNotNil: [ aStream nextPut: cm ] ] ]
]

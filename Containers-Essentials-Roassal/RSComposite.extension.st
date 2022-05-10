Extension { #name : #RSComposite }

{ #category : #'*Containers-Essentials-Roassal' }
RSComposite class >> ghost: model [

	^ self new
		  model: model;
		  extent: 0 @ 0;
		  color: Color transparent;
		  noPaint;
		  propertyAt: #isGhostShape put: true;
		  yourself
]

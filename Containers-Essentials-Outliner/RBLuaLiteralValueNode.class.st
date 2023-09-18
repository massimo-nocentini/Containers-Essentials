Class {
	#name : 'RBLuaLiteralValueNode',
	#superclass : 'RBLiteralValueNode',
	#category : 'Containers-Essentials-Outliner-Presenters',
	#package : 'Containers-Essentials-Outliner',
	#tag : 'Presenters'
}

{ #category : 'converting' }
RBLuaLiteralValueNode >> asVarShapeUsingPresenter: codePresenter clientSlotDescriptorVisitor: visitor [

	^ TSChunk new
		  language: 'lua';
		  sourceCode: self value;
		  asRSPangoShapeUsingFont: LogicalFont pangoMonospace
]

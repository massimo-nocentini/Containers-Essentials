Class {
	#name : #FFICairoPathDataTypeEnumeration,
	#superclass : #FFIEnumeration,
	#classVars : [
		'CAIRO_PATH_CLOSE_PATH',
		'CAIRO_PATH_CURVE_TO',
		'CAIRO_PATH_LINE_TO',
		'CAIRO_PATH_MOVE_TO'
	],
	#category : #'Containers-Essentials-Roassal'
}

{ #category : #'enum declaration' }
FFICairoPathDataTypeEnumeration class >> enumDecl [

	"self initialize"
	^ #( 
			CAIRO_PATH_MOVE_TO 0 
			CAIRO_PATH_LINE_TO 1 
			CAIRO_PATH_CURVE_TO 2
			CAIRO_PATH_CLOSE_PATH 3
		)
]

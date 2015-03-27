package org.uqbar.arena.examples.materias.view.components

import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox

class LabeledTextBox extends Panel{
	
	var Label label
	var TextBox textBox
	
	new(Container container) {
		super(container)
		layout = new HorizontalLayout
		label = new Label(this)
		textBox = new TextBox(this)
		textBox.width=200
		label.width = 150
	}
	
	def LabeledTextBox setText(String text){ 
		label.text = text
		this
	}
	
	def bindValueToProperty(String property) {
		textBox.bindValueToProperty(property)
	}
	
	override Panel setWidth(int ancho){
		textBox.width = ancho
		this 
	}
	
	
}
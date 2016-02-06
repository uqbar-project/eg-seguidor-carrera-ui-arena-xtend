package ar.edu.seguidorCarrera.view.components

import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.TextBox

class LabeledTextBox extends AbstractLabeledWidget {
	
	TextBox textBox
	
	new(Container container) {
		super(container)
	}
	
	override LabeledTextBox setWidth(int ancho){
		textBox.width = ancho
		this 
	}
	
	override createWidget(AbstractLabeledWidget widget) {
		textBox = new TextBox(this)
		this
	}
	
	override bindValueToProperty(String property) {
		textBox.bindValueToProperty(property)
		this
	}
	
}
package ar.edu.seguidorCarrera.view.components

import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Container

class LabeledCheckBox extends AbstractLabeledWidget {
	
	CheckBox checkBox
	
	new(Container container) {
		super(container)
	}
	
	override createWidget(AbstractLabeledWidget widget) {
		checkBox = new CheckBox(this)
	}
	
	override bindValueToProperty(String property) {
		checkBox.bindValueToProperty(property)
		this
	}
	
}
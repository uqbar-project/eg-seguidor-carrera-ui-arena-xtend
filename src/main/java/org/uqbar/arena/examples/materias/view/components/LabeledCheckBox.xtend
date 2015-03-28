package org.uqbar.arena.examples.materias.view.components

import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel

class LabeledCheckBox extends Panel{
	
	var Label label
	var CheckBox checkBox
	
	new(Container container) {
		super(container)
		layout = new HorizontalLayout
		label = new Label(this)
		label.width = 150
		checkBox = new CheckBox(this)
	}
	
	def LabeledCheckBox setText(String text){ 
		label.text = text
		this
	}
	
	def bindValueToProperty(String property) {
		checkBox.bindValueToProperty(property)
	}
	
}
package org.uqbar.arena.examples.materias.view.components

import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.Panel

class LabeledSelector<T> extends Panel{
	
	var Label label
	var Selector<T> selector
	
	new(Container container) {
		super(container)
		layout = new HorizontalLayout
		label = new Label(this)
		selector = new Selector<T>(this)
		selector.width=200
		label.width = 150
	}
	
	def LabeledSelector<T> setText(String text){ 
		label.text = text
		this
	}
	
	def bindValueToProperty(String property) {
		selector.bindValueToProperty(property)
	}
	
	def bindItemsToProperty(String property){
		selector.bindItemsToProperty(property)
	}
}
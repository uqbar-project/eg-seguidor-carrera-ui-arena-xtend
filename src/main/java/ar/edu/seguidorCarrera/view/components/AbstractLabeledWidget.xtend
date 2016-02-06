package ar.edu.seguidorCarrera.view.components

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Widget

@Accessors
abstract class AbstractLabeledWidget extends Panel {

	Label label
	
	new(Container container) {
		super(container)
		layout = new HorizontalLayout
		label = new Label(this)
		label.width = 150
		createWidget(this) 
	}
	
	def AbstractLabeledWidget setText(String text){ 
		label.text = text
		this
	}
	
	abstract def Widget createWidget(AbstractLabeledWidget widget)
	
	abstract def AbstractLabeledWidget bindValueToProperty(String property)
		
}
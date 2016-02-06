package ar.edu.seguidorCarrera.view.components

import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel

class Titulo extends Label {
	
	new(Panel container, String text, Integer fontSize) {
		super(container)
		this.text = text
		this.fontSize = fontSize
	}
	
	new(Panel container, String text) {
		super(container)
		this.text = text
		this.fontSize = 14
	}
	
}
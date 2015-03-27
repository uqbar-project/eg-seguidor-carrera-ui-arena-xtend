package org.uqbar.arena.examples.materias.view

import org.uqbar.arena.examples.materias.domain.Nota
import org.uqbar.arena.windows.WindowOwner

class CrearNotaWindow extends NotaEditableWindow{
	
	new(WindowOwner owner, Nota model) {
		super(owner, model)
		title = "Crear Nota"
	}
}
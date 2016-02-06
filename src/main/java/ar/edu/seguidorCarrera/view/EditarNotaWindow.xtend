package ar.edu.seguidorCarrera.view

import ar.edu.seguidorCarrera.domain.Nota
import org.uqbar.arena.windows.WindowOwner

class EditarNotaWindow extends NotaEditableWindow{
	
	new(WindowOwner owner, Nota model) {
		super(owner, model)
		title = "Editar Nota"
	}
}
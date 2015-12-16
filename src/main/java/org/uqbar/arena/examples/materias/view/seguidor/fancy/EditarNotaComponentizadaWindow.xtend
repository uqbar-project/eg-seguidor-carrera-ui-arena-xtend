package org.uqbar.arena.examples.materias.view.seguidor.fancy

import org.uqbar.arena.examples.materias.domain.Nota
import org.uqbar.arena.examples.materias.view.components.LabeledCheckBox
import org.uqbar.arena.examples.materias.view.components.LabeledTextBox
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class EditarNotaComponentizadaWindow extends Dialog<Nota>{
	new(WindowOwner owner, Nota model) {
		super(owner, model)
	}

	override protected createFormPanel(Panel mainPanel) {
		new LabeledTextBox(mainPanel).setText("Fecha:").bindValueToProperty("fecha")
		new LabeledTextBox(mainPanel).setText("Descripción:").bindValueToProperty("descripcion")
		new LabeledCheckBox(mainPanel).setText("Aprobado").bindValueToProperty("estaAprobada")
		new Button(mainPanel) => [
			caption = "Aceptar"
			onClick [|this.close]
		]
	}
}

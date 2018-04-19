package ar.edu.seguidorCarrera.view.seguidor.fancy

import ar.edu.seguidorCarrera.domain.Nota
import ar.edu.seguidorCarrera.view.components.LabeledCheckBox
import ar.edu.seguidorCarrera.view.components.LabeledTextBox
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner

class EditarNotaComponentizadaWindow extends TransactionalDialog<Nota>{
	new(WindowOwner owner, Nota model) {
		super(owner, model)
	}

	override protected createFormPanel(Panel mainPanel) {
		new LabeledTextBox(mainPanel) => [
			text = "Fecha:"
			bindValueToProperty("fecha")
		]
		new LabeledTextBox(mainPanel) => [
			text = "Descripción:"
			width = 250
			bindValueToProperty("descripcion") 
		]
		new LabeledCheckBox(mainPanel) => [
			text = "Aprobado"
			bindValueToProperty("estaAprobada")
		]
		new Button(mainPanel) => [
			caption = "Aceptar"
			onClick [|this.accept()]
		]
	}
}

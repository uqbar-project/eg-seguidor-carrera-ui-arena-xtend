package org.uqbar.arena.examples.materias.view

import org.uqbar.arena.examples.materias.domain.Nota
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class NotaEditableWindow extends Dialog<Nota> {
	
	new(WindowOwner owner, Nota model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel owner) {
		var mainPanel = new Panel(owner)

		mainPanel.layout = new ColumnLayout(2)
		new Label(mainPanel).text = "Fecha:"
		new TextBox(mainPanel).bindValueToProperty("fecha")

		new Label(mainPanel).text = "Descripción:"
		new TextBox(mainPanel) => [
			bindValueToProperty("descripcion")
			width = 150
		]

		new CheckBox(mainPanel).bindValueToProperty("estaAprobada")
		new Label(mainPanel).text = "Aprobado"

		new Button(mainPanel) => [
			caption = "Aceptar"
			onClick [|this.close]
		]
	}
}

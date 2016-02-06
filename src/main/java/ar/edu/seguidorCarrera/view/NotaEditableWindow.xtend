package ar.edu.seguidorCarrera.view

import ar.edu.seguidorCarrera.domain.Nota
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class NotaEditableWindow extends Dialog<Nota> {
	
	new(WindowOwner owner, Nota model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel owner) {
		val mainPanel = new Panel(owner)
		mainPanel.layout = new ColumnLayout(2)
		
		new Label(mainPanel).text = "Fecha:"
		new TextBox(mainPanel).value <=> "fecha"

		new Label(mainPanel).text = "Descripción:"
		new TextBox(mainPanel) => [
			value <=> "descripcion"
			width = 150
		]

		new CheckBox(mainPanel).value <=> "estaAprobada"
		new Label(mainPanel).text = "Aprobado"

		new Button(mainPanel) => [
			caption = "Aceptar"
			onClick [|this.close]
		]
	}
	
}

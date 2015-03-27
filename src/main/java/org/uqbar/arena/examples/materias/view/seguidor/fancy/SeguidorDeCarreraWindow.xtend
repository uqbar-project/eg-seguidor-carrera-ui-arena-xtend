package org.uqbar.arena.examples.materias.view.seguidor.fancy

import java.text.SimpleDateFormat
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.examples.materias.domain.Materia
import org.uqbar.arena.examples.materias.domain.Nota
import org.uqbar.arena.examples.materias.domain.appModel.SeguidorDeCarreraAppModel
import org.uqbar.arena.examples.materias.view.CrearNotaWindow
import org.uqbar.arena.examples.materias.view.EditarNotaWindow
import org.uqbar.arena.examples.materias.view.NuevaMateriaWindow
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class SeguidorDeCarreraWindow extends SimpleWindow<SeguidorDeCarreraAppModel> {

	new(WindowOwner parent, SeguidorDeCarreraAppModel model) {
		super(parent, model)
	}

	override protected addActions(Panel actionsPanel) {
		//no queremos usar este template default
	}

	override protected createFormPanel(Panel mainPanel) {
		//no queremos usar este template default
	} 

	override createMainTemplate(Panel mainPanel) {
		this.title = "Seguidor de carrera"

		mainPanel.layout = new VerticalLayout 
		//Agregamos el titulo
		new Label(mainPanel) => [
			text = "Seguidor de Carrera"
			fontSize = 20
		]

		//Agregamos el contenido
		var Panel contentPanel = new Panel(mainPanel)
		contentPanel.layout = new ColumnLayout(2)
		this.crearListadoDeMaterias(contentPanel)
		this.crearEdicionDeMateriaSeleccionada(contentPanel)
	}

	def crearListadoDeMaterias(Panel owner) {
		var Panel panelDeListadoDeMaterias = new Panel(owner)
		panelDeListadoDeMaterias.layout = new VerticalLayout

		new Label(panelDeListadoDeMaterias).text = "Materias"
		new List<Materia>(panelDeListadoDeMaterias) => [
				bindItemsToProperty("carrera.materias").adapter = new PropertyAdapter(Materia, "nombreMateria")
				heigth = 150
				width = 130
				bindValueToProperty("materiaSeleccionada")
			]
		new Button(panelDeListadoDeMaterias) =>[
			caption = "Nueva Materia"
			onClick = [ | new NuevaMateriaWindow(this, this.modelObject.carrera).open ]
			
		] 
	}

	def crearEdicionDeMateriaSeleccionada(Panel owner) {
		var Panel materiaCompletaPanel = new Panel(owner)
		materiaCompletaPanel.layout = new VerticalLayout

		new Label(materiaCompletaPanel)=>[
			bindValueToProperty("materiaSeleccionada.nombreMateria")
			fontSize = 13
		]
		
		var Panel panelDeEdicionDeMateria = new Panel(materiaCompletaPanel)
		panelDeEdicionDeMateria.layout = new ColumnLayout(2)
		
		new Label(panelDeEdicionDeMateria).text="Aprobo:"
		new CheckBox(panelDeEdicionDeMateria).bindValueToProperty("materiaSeleccionada.estaAprobada")
		
		new Label(panelDeEdicionDeMateria).text="Año de cursada:"
		new TextBox(panelDeEdicionDeMateria)=>[
			bindValueToProperty("materiaSeleccionada.anioCursada")
			width=200
		]
		
		new Label(panelDeEdicionDeMateria).text="Profesor de cursada:"
		new TextBox(panelDeEdicionDeMateria)=>[
			bindValueToProperty("materiaSeleccionada.profesor")
			width=200
		]
		
		new Label(panelDeEdicionDeMateria).text = "Ubicación:"
		new Selector(panelDeEdicionDeMateria) => [
			bindItemsToProperty("ubicacionesPosibles")
			bindValueToProperty("materiaSeleccionada.ubicacion")
			width=200
		]
		
		new Label(panelDeEdicionDeMateria).text = "Notas de Cursada"
		var tablaDeNotas = new Table<Nota>(panelDeEdicionDeMateria, Nota)
		tablaDeNotas.bindItemsToProperty("materiaSeleccionada.notas")
		tablaDeNotas.bindValueToProperty("notaSeleccionada")
		
		new Column(tablaDeNotas) =>[
			title = "Fecha"
			bindContentsToTransformer([ nota | new SimpleDateFormat("dd/MM/YYYY").format(nota.fecha)])
		]
		
		new Column<Nota>(tablaDeNotas)=>[
			bindContentsToProperty("descripcion")
			title = "Descripción"
		]

		new Column(tablaDeNotas) =>[
			title = "Aprobado"
//			bindContentsToTransformer([ nota | if(nota.estaAprobada) "Si" else "No"])
			bindContentsToProperty("estaAprobada")
		]
		
		var botoneraPanel = new Panel(materiaCompletaPanel)
		botoneraPanel.layout = new HorizontalLayout
		
		new Button(botoneraPanel)=>[
			caption="Editar"
			width=100
			onClick = [|new EditarNotaWindow(this, this.modelObject.notaSeleccionada).open]
		]
			
		new Button(botoneraPanel)=>[
			caption="+"
			width=100
			onClick = [| 
				val nota = this.modelObject.nuevaNota
				new CrearNotaWindow(this, nota).open
			]
		]
		
		new Button(botoneraPanel)=>[
			caption="-"
			width=100
			onClick = [| 
				this.modelObject.eliminarNota
			]
		]
	}
	
}

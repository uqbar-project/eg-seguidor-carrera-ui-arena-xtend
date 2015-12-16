package org.uqbar.arena.examples.materias.view.seguidor.fancy

import java.text.SimpleDateFormat
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.examples.materias.domain.Materia
import org.uqbar.arena.examples.materias.domain.Nota
import org.uqbar.arena.examples.materias.domain.appModel.SeguidorDeCarreraAppModel
import org.uqbar.arena.examples.materias.view.NuevaMateriaWindow
import org.uqbar.arena.examples.materias.view.components.LabeledCheckBox
import org.uqbar.arena.examples.materias.view.components.LabeledSelector
import org.uqbar.arena.examples.materias.view.components.LabeledTextBox
import org.uqbar.arena.examples.materias.view.components.Titulo
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class SeguidorDeCarreraComponentizadoWindow extends SimpleWindow<SeguidorDeCarreraAppModel> {

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
		
		new Titulo(mainPanel, "Seguidor de Carrera", 20)

		//Agregamos el contenido
		var Panel contentPanel = new Panel(mainPanel)
		contentPanel.layout = new ColumnLayout(2)
		this.crearListadoDeMaterias(contentPanel)
		this.crearEdicionDeMateriaSeleccionada(contentPanel)
	}

	def crearListadoDeMaterias(Panel owner) {
		var Panel panelDeListadoDeMaterias = new Panel(owner)

		new Titulo(panelDeListadoDeMaterias,"Materias")
		new List<Materia>(panelDeListadoDeMaterias) => [
				bindItemsToProperty("carrera.materias").adapter = new PropertyAdapter(Materia, "nombreMateria")
				height = 150
				width = 130
				bindValueToProperty("materiaSeleccionada")
			]
		new Button(panelDeListadoDeMaterias) =>[
			caption = "Nueva Materia"
			onClick [ | new NuevaMateriaWindow(this, this.modelObject.carrera).open ]
		] 
	}

	def crearEdicionDeMateriaSeleccionada(Panel owner) {
		var Panel materiaCompletaPanel = new Panel(owner)
		materiaCompletaPanel.layout = new VerticalLayout

		new Label(materiaCompletaPanel)=>[
			bindValueToProperty("materiaSeleccionada.nombreMateria")
			fontSize = 13
		]
		
		new LabeledCheckBox(materiaCompletaPanel)
			.setText("Aprobo:")
			.bindValueToProperty("materiaSeleccionada.estaAprobada")
		
		new LabeledTextBox(materiaCompletaPanel)
			.setText("Año de cursada:")
			.bindValueToProperty("materiaSeleccionada.anioCursada")
		
		new LabeledTextBox(materiaCompletaPanel)
			.setText("Profesor de cursada:")
			.bindValueToProperty("materiaSeleccionada.profesor")
		
		new LabeledSelector(materiaCompletaPanel)=>[
			text="Ubicación:"
			bindItemsToProperty("ubicacionesPosibles")
			bindValueToProperty("materiaSeleccionada.ubicacion")
		]
		
		crearEdicionDeNotas(materiaCompletaPanel)
	}
	
	def crearEdicionDeNotas(Panel panelDeEdicionDeMateria) {
		new Titulo(panelDeEdicionDeMateria, "Notas de Cursada", 12)
		
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
			bindContentsToProperty("estaAprobada")
		]
		
		var botoneraPanel = new Panel(panelDeEdicionDeMateria)
		botoneraPanel.layout = new HorizontalLayout
		
		new Button(botoneraPanel)=>[
			caption="Editar"
			width=100
			onClick [|new EditarNotaComponentizadaWindow(this, this.modelObject.notaSeleccionada)
					.setTitle("Editar Nota")
					.open
			]
		]
			
		new Button(botoneraPanel)=>[
			caption="+"
			width=100
			onClick [| 
				new EditarNotaComponentizadaWindow(this, this.modelObject.nuevaNota)
					.setTitle("Nueva Nota")
					.open
			]
		]
		
		new Button(botoneraPanel)=>[
			caption="-"
			width=100
			onClick [| 
				this.modelObject.eliminarNota
			]
		]
	}
	
	
}

package ar.edu.seguidorCarrera.view.seguidor.fancy

import ar.edu.seguidorCarrera.appModel.SeguidorDeCarreraAppModel
import ar.edu.seguidorCarrera.domain.Materia
import ar.edu.seguidorCarrera.domain.Nota
import ar.edu.seguidorCarrera.view.NuevaMateriaWindow
import ar.edu.seguidorCarrera.view.components.LabeledCheckBox
import ar.edu.seguidorCarrera.view.components.LabeledSelector
import ar.edu.seguidorCarrera.view.components.LabeledTextBox
import ar.edu.seguidorCarrera.view.components.Titulo
import java.text.SimpleDateFormat
import java.util.Date
import org.uqbar.arena.bindings.PropertyAdapter
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

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

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
		val Panel contentPanel = new Panel(mainPanel)
		contentPanel.layout = new ColumnLayout(2)
		this.crearListadoDeMaterias(contentPanel)
		this.crearEdicionDeMateriaSeleccionada(contentPanel)
	}

	def crearListadoDeMaterias(Panel owner) {
		val Panel panelDeListadoDeMaterias = new Panel(owner)

		new Titulo(panelDeListadoDeMaterias, "Materias")
		new List<Materia>(panelDeListadoDeMaterias) => [
				(items <=> "carrera.materias").adapter = new PropertyAdapter(Materia, "nombreMateria")
				height = 150
				width = 270
				value <=> "materiaSeleccionada"
			]
			
		new Button(panelDeListadoDeMaterias) =>[
			caption = "Nueva Materia"
			onClick [ | new NuevaMateriaWindow(this, this.modelObject.carrera).open ]
		] 
	}

	def crearEdicionDeMateriaSeleccionada(Panel owner) {
		val Panel materiaCompletaPanel = new Panel(owner)
		materiaCompletaPanel.layout = new VerticalLayout

		new Label(materiaCompletaPanel)=>[
			value <=> "materiaSeleccionada.nombreMateria"
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
			text = "Ubicación:"
			bindItemsToProperty("ubicacionesPosibles")
			bindValueToProperty("materiaSeleccionada.ubicacion")
		]
		
		crearEdicionDeNotas(materiaCompletaPanel)
	}
	
	def crearEdicionDeNotas(Panel panelDeEdicionDeMateria) {
		new Titulo(panelDeEdicionDeMateria, "Notas de Cursada", 12)
		
		val tablaDeNotas = new Table<Nota>(panelDeEdicionDeMateria, Nota) => [
			items <=> "materiaSeleccionada.notas"
			value <=> "notaSeleccionada"
		]
		
		new Column(tablaDeNotas) =>[
			title = "Fecha"
			bindContentsToProperty("fecha").transformer = [ Date fecha | new SimpleDateFormat("dd/MM/YYYY").format(fecha)] 
		]
		
		new Column<Nota>(tablaDeNotas)=>[
			bindContentsToProperty("descripcion")
			title = "Descripción"
		]
		
		new Column(tablaDeNotas) =>[
			title = "Aprobado"
			bindContentsToProperty("estaAprobada").transformer = [ Boolean estaAprobada | if (estaAprobada) "SI" else "NO" ]
		]
		
		val botoneraPanel = new Panel(panelDeEdicionDeMateria)
		botoneraPanel.layout = new HorizontalLayout
		
		new Button(botoneraPanel)=>[
			caption = "Editar"
			width = 100
			onClick [ | editarNota("Editar Nota", this.modelObject.notaSeleccionada) ]
		]
			
		new Button(botoneraPanel) => [
			caption = "+"
			width = 100
			onClick [ | editarNota("Nueva Nota", this.modelObject.nuevaNota) ]
		]
		
		new Button(botoneraPanel) => [
			caption = "-"
			width = 100
			onClick [| 
				this.modelObject.eliminarNota
			]
		]
	}
	
	def editarNota(String titulo, Nota nota) {
		new EditarNotaComponentizadaWindow(this, nota) => [
			title = titulo
			open
		]
	}
	
}

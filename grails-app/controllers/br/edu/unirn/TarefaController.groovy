package br.edu.unirn

import grails.converters.JSON
import grails.gorm.transactions.Transactional

class TarefaController {

    static scaffold = Tarefa

    def index(){}

    @Transactional
    def save(){
        params << request.JSON
        Tarefa tarefa = new Tarefa()
        bindData(tarefa, params, [exclude:['dataLimite']])
        tarefa.dataLimite = params.date('dataLimite', 'dd/MM/yyyy')
        tarefa.tipoTarefa = TipoTarefa.get(params.tipoTarefa.id)
        tarefa.usuarioAbertura = Usuario.get(session?.usuario?.id)

        println request.JSON

        println "T ${tarefa.validate()}"
        if(!tarefa.save(flush: true)){
            tarefa.errors.each {println it}
            render status: 500
            return
        }

        render status: 200
    }

    def show(){
        Tarefa tarefa = Tarefa.get(params.id)

        def logs = []

        tarefa.logTarefas.each {
            logs.add([ id: it.id,
                       texto: it.texto,
                       data : it.dateCreated.format('dd/MM/yyyy hh:mm'),
                       usuarioLog: it.usuarioLog.email,
                       porcentagem: it.porcentagem,
                       statusTarefa: it.statusTarefa.descricao])
        }

        def t = {}
        t = ([
                id: tarefa.id,
                titulo: tarefa.titulo,
                texto: tarefa.texto,
                usuarioAbertura:[
                        id: tarefa.usuarioAbertura.id,
                        email: tarefa.usuarioAbertura.email],
                usuarioResponsavel:[
                        id: tarefa.usuarioResponsavel.id,
                        email: tarefa.usuarioResponsavel.email],
                dataLimite: tarefa.dataLimite.format("dd/MM/yyyy"),
                tipoTarefa: [
                        id: tarefa.tipoTarefa.id,
                        descricao: tarefa.tipoTarefa.descricao],
                statusTarefa: tarefa.statusTarefa.name(),
                porcentagem: tarefa.porcentagem,
                logs: logs
        ])

        render t as JSON

    }

    def list(){
        def retorno = []

        Tarefa.list().each {
            retorno.add([
                id: it.id,
                titulo: it.titulo,
                usuarioAbertura: [
                        id: it.usuarioAbertura.id,
                        email: it.usuarioAbertura.email],
                usuarioResponsavel:[
                        id: it.usuarioResponsavel.id,
                        email: it.usuarioResponsavel.email],
                dataLimite: it.dataLimite.format("dd/MM/yyyy"),
                tipoTarefa: it.tipoTarefa.descricao,
                statusTarefa: it.statusTarefa.name(),
                porcentagem: it.porcentagem
            ])
        }

        render retorno as JSON
    }

    def filtrar(){

        params << request.JSON

        def sql = ""

        if(params.usuarioResponsavel.id != '' || params.tipoTarefa.id != '' || params.statusTarefa != ''){
            sql = "WHERE "
        if(params.usuarioResponsavel.id != ''){
            sql += "t.usuarioResponsavel = ${params.usuarioResponsavel.id} "
        }

        if(params.tipoTarefa.id != ''){
            if(params.usuarioResponsavel.id != ''){
                sql += "and "
            }
            sql += "t.tipoTarefa = ${params.tipoTarefa.id}"
        }

        if(params.statusTarefa != ''){
            if(params.usuarioResponsavel.id != '' || params.tipoTarefa.id != '' ){
                sql += "and "
            }
            sql += "t.statusTarefa = '${params.statusTarefa.toUpperCase()}'"
        }

        }

        def retorno = []

        def tarefas = Tarefa.executeQuery("FROM Tarefa t "+sql+ " ORDER BY t.id ASC")

        tarefas.each {
            retorno.add([
                    id: it.id,
                    titulo: it.titulo,
                    usuarioAbertura: [
                            id: it.usuarioAbertura.id,
                            email: it.usuarioAbertura.email],
                    usuarioResponsavel:[
                            id: it.usuarioResponsavel.id,
                            email: it.usuarioResponsavel.email],
                    dataLimite: it.dataLimite.format("dd/MM/yyyy"),
                    tipoTarefa: it.tipoTarefa.descricao,
                    statusTarefa: it.statusTarefa.name(),
                    porcentagem: it.porcentagem
            ])
        }

        render retorno as JSON
    }

    def update(){
        params << request.JSON
        Tarefa tarefa = Tarefa.get(params.id)

        bindData(tarefa, params, [exclude:['dataLimite']])
        tarefa.dataLimite = params.date('dataLimite', 'dd/MM/yyyy')

        if(!tarefa.save(flush: true)){
            render status: 500
            return
        }

        render status: 200
    }
}

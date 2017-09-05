package br.edu.unirn

class LogTarefaController {

    static scaffold = LogTarefa

    def save(){
        params << request.JSON
        Tarefa tarefa = Tarefa.get(params.tarefa.id)
        LogTarefa log = new LogTarefa()
        bindData(log, params)
        log.usuarioLog = Usuario.get(session.usuario.id)

        if(!log.save(flush: true)){
            log.errors.each {println it}
            render status: 500
            return
        }

        tarefa.porcentagem = log.porcentagem
        tarefa.statusTarefa = log.statusTarefa

        if(!tarefa.save(flush: true)){
            tarefa.errors.each {println it}
            render status: 500
            return
        }

        render status: 200
    }

}

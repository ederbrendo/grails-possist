package br.edu.unirn

import br.edu.unirn.tipos.StatusTarefa

class Tarefa {

    String titulo
    String texto
    Usuario usuarioAbertura
    Usuario usuarioResponsavel

    Date dataLimite = new Date() + 7

    TipoTarefa tipoTarefa
    StatusTarefa statusTarefa

    int porcentagem = 0

    Date dateCreated
    Date lastUpdated

    static hasMany = [logTarefas: LogTarefa]

    static constraints = {
        titulo maxSize: 400
        texto widget: "textarea"
        usuarioAbertura()
        usuarioResponsavel nullable: true
        dataLimite()
        statusTarefa()
        tipoTarefa()
        porcentagem()
    }

    static mapping = {
        texto type: "text"
        logTarefas sort: 'id', order: 'asc'
    }

    String toString() { titulo }
}

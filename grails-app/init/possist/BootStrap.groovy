package possist

import br.edu.unirn.TipoTarefa
import br.edu.unirn.Usuario
import br.edu.unirn.tipos.StatusTarefa
import grails.util.Environment

class BootStrap {

    def init = { servletContext ->
        if (Environment.developmentMode) {
            ["Desenvolvimento", "Suporte", "Testes", "Concluído"].each { tipo ->
                TipoTarefa.findByDescricao(tipo) ?: new TipoTarefa(descricao: tipo).save(flush: true)
            }

            if(!Usuario.findByEmail("admin@admin.com")){
                Usuario usuario = new Usuario()
                usuario.email = "admin@admin.com"
                usuario.senha = "admin"
                usuario.save(flush: true)
            }

            if(!Usuario.findByEmail("eder@eder.com")){
                Usuario usuario = new Usuario()
                usuario.email = "eder@eder.com"
                usuario.senha = "eder"
                usuario.save(flush: true)
            }

        }
    }
    def destroy = {
    }
}

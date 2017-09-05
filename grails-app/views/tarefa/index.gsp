<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tarefa.label', default: 'Tarefa')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="tarefa" v-cloak="">
            <ol class="breadcrumb">
                <li><a href="${createLink(uri: '/')}">Inicio</a></li>
                <li class="active">Tarefa</li>
            </ol>

            <div class="panel panel-default">
                <button class="btn btn-success pull-right" @click="novaTarefa">
                    Nova Tarefa
                </button>
                <div class="panel-heading"><g:message code="default.list.label" args="[entityName]" /></div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-12">

                            <form class="form-horizontal">

                                <div class="form-group">
                                    <label for="usuarioResponsavel" class="col-sm-2 control-label">Usuario Responsavel</label>
                                    <div class="col-sm-10">
                                        <g:select name="usuarioResponsavel" class="form-control" v-model="filtro.usuarioResponsavel.id" noSelection="['':'-- Todos --']"
                                                  from="${br.edu.unirn.Usuario.list()}" optionValue="email" optionKey="id"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="tipoTarefa" class="col-sm-2 control-label">Tipo Tarefa</label>
                                    <div class="col-sm-10">
                                        <g:select name="tipoTarefa" class="form-control" v-model="filtro.tipoTarefa.id" noSelection="['':'-- Todos --']"
                                                  from="${br.edu.unirn.TipoTarefa.list()}" optionValue="descricao" optionKey="id"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="statusTarefa" class="col-sm-2 control-label">Status Tarefa</label>
                                    <div class="col-sm-10">
                                        <g:select name="statusTarefa" class="form-control" v-model="filtro.statusTarefa" noSelection="['':'-- Todos --']"
                                                  from="${br.edu.unirn.tipos.StatusTarefa.values()}" optionValue="descricao" keys="${br.edu.unirn.tipos.StatusTarefa?.values()*.name()}" />
                                    </div>
                                </div>

                            </form>

                            <button @click="filtrar" class="btn btn-success pull-right">
                               Filtrar
                            </button>

                        </div>
                        <div class="col-sm-12 table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Titulo</th>
                                        <th>Usuario Abertura</th>
                                        <th>Usuario Resp.</th>
                                        <th>Data Limite</th>
                                        <th>Tipo Tarefa</th>
                                        <th>Status</th>
                                        <th>%</th>
                                        <th>Ação</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <tr v-if="loading">
                                    <td colspan="7">Carregando....</td>
                                </tr>
                                <tr v-for="tarefa in tarefas" :key="tarefa.id">
                                    <td>{{tarefa.id}}</td>
                                    <td>{{tarefa.titulo}}</td>
                                    <td>{{tarefa.usuarioAbertura.email}}</td>
                                    <td>{{tarefa.usuarioResponsavel.email}}</td>
                                    <td>{{tarefa.dataLimite}}</td>
                                    <td>{{tarefa.tipoTarefa}}</td>
                                    <td>{{tarefa.statusTarefa}}</td>
                                    <td>{{tarefa.porcentagem}}</td>
                                    <td>
                                        <div class="btn-group-xs" role="group" aria-label="...">
                                            <button class="btn btn-success pull-right" @click="showTarefa(tarefa.id)">
                                        Visualizar Tarefa
                                    </button>
                                        </div></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>


                </div>
            </div>

            <div class="modal fade" tabindex="-1" role="dialog" id="formTarefa">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div v-if="!tarefa.id" class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Nova Tarefa</h4>
                        </div>
                        <div v-if="tarefa.id" class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Tarefa {{tarefa.id}}</h4>
                        </div>
                        <div class="modal-body">
                            <form class="form-horizontal">
                                <g:render template="form"/>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                            <button type="button" class="btn btn-primary" @click="salvarTarefa" v-if="!tarefa.id"><i class="fa fa-floppy-o"></i> Salvar Tarefa</button>
                            <button type="button" class="btn btn-primary" @click="updateTarefa" v-if="tarefa.id"><i class="fa fa-floppy-o"></i> Alterar Tarefa</button>
                        </div>
                    </div>
                </div>
            </div>


            <div class="modal fade" tabindex="-1" role="dialog" id="formLogTarefa">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Novo Log Tarefa</h4>
                        </div>
                        <div class="modal-body">
                            <form class="form-horizontal">
                                <g:render template="/logTarefa/form"/>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                            <button type="button" class="btn btn-primary" @click="salvarLogTarefa(logTarefa)" v-if="!logTarefa.id"><i class="fa fa-floppy-o"></i> Salvar Log Tarefa</button>
                            <button type="button" class="btn btn-primary" @click="updateLogTarefa(logTarefa)" v-if="logTarefa.id"><i class="fa fa-floppy-o"></i> Alterar Tarefa</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" tabindex="-1" role="dialog" id="showTarefa">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">Tarefa {{tarefa.id}}</h4>
                        </div>
                        <div class="modal-body">
                            <form class="form-horizontal">
                                <g:render template="show"/>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                            <button type="button" class="btn btn-primary" @click="editTarefa(tarefa)" v-if="tarefa.id"><i class="fa fa-floppy-o"></i> Alterar Tarefa</button>
                            <button type="button" class="btn btn-primary" @click="novoLogTarefa(tarefa)" v-if="tarefa.id"><i class="fa fa-floppy-o"></i> Inserir Log Tarefa</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <content tag="javascript">
        <asset:javascript src="controllers/tarefa.js"/>
    </content>
    </body>
</html>
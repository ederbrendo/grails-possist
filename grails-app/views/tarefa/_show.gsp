<table class="table">
    <tbody>

    <tr class="prop">
        <td valign="top" class="name">ID</td>

        <td valign="top" class="value">{{tarefa.id}}</td>
    </tr>

    <tr class="prop">
        <td valign="top" class="name">Titulo</td>

        <td valign="top" class="value">{{tarefa.titulo}}</td>
    </tr>

    <tr class="prop">
        <td valign="top" class="name">Texto</td>

        <td valign="top" class="value">{{tarefa.texto}}</td>
    </tr>

    <tr class="prop">
        <td valign="top" class="name">Usuario Abertura</td>

        <td valign="top" class="value">{{tarefa.usuarioAbertura.email}}</td>
    </tr>

    <tr class="prop">
        <td valign="top" class="name">Usuario Responsavel</td>

        <td valign="top" class="value">{{tarefa.usuarioResponsavel.email}}</td>
    </tr>

    <tr class="prop">
        <td valign="top" class="name">Data Limite</td>

        <td valign="top" class="value">{{tarefa.dataLimite}}</td>
    </tr>

    <tr class="prop">
        <td valign="top" class="name">Tipo Tarefa</td>

        <td valign="top" class="value">{{tarefa.tipoTarefa.descricao}}</td>
    </tr>

    <tr class="prop">
        <td valign="top" class="name">Status Tarefa</td>

        <td valign="top" class="value">{{tarefa.statusTarefa}}</td>
    </tr>

    <tr class="prop">
        <td valign="top" class="name">Porcentagem</td>

        <td valign="top" class="value">{{tarefa.porcentagem}}%</td>
    </tr>


    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Texto</th>
            <th>Usuario Log</th>
            <th>Data</th>
            <th>Status Tarefa</th>
            <th>%</th>
        </tr>
        </thead>
        <tbody>
        <tr v-if="loading">
            <td colspan="7">Carregando....</td>
        </tr>
        <tr v-for="log in tarefa.logs">
        <td>{{log.id}}</td>
        <td>{{log.texto}}</td>
        <td>{{log.usuarioLog}}</td>
        <td>{{log.data}}</td>
        <td>{{log.statusTarefa}}</td>
        <td>{{log.porcentagem}}</td>

        </tr>
        </tbody>
    </table>



    </tbody>
</table>


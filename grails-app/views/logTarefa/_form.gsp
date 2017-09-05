<div class="form-group">
    <label for="tarefa" class="col-sm-2 control-label">Tarefa</label>
    <div class="col-sm-10">
        <g:select name="tarefa" class="form-control" disabled="disabled" v-model="logTarefa.tarefa.id" noSelection="['':'-- Selecione --']"
                  from="${br.edu.unirn.Tarefa.list()}" optionValue="titulo" optionKey="id"/>
    </div>
</div>

<div class="form-group">
    <label for="texto" class="col-sm-2 control-label">Texto</label>
    <div class="col-sm-10">
        <g:textArea name="texto" class="form-control" v-model="logTarefa.texto"/>
    </div>
</div>

<div class="form-group">
    <label for="statusTarefa" class="col-sm-2 control-label">Status Tarefa</label>
    <div class="col-sm-10">
        <g:select name="statusTarefa" class="form-control" v-model="logTarefa.statusTarefa" noSelection="['':'-- Selecione --']"
                  from="${br.edu.unirn.tipos.StatusTarefa.values()}" optionValue="descricao" keys="${br.edu.unirn.tipos.StatusTarefa?.values()*.name()}" />
    </div>
</div>

<div class="form-group">
    <label for="porcentagem" class="col-sm-2 control-label">Porcentagem</label>
    <div class="col-sm-10">
        <g:select name="porcentagem" from="${(0..100).step(10)}" class="form-control" v-model="logTarefa.porcentagem"/>
       %{-- <g:field type="number" name="porcentagem" class="form-control" v-model="logTarefa.porcentagem"/>--}%
    </div>
</div>
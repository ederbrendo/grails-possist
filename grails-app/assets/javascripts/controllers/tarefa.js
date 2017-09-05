var tarefa = new Vue({
    el: '#tarefa',
    data: {
        tarefas: [],
        tarefa: {},
        logTarefas:[],
        logTarefa: {},
        filtro: {usuarioResponsavel:{id:""},tipoTarefa:{id:""},statusTarefa:""},
        loading: false
    },
    methods: {
        getTarefas: function(){
            this.loading = true;
            this.$http.get(window.baseUrl+"tarefa/list/").then(function(resp){
                this.tarefas = resp.data;
                this.loading = false;
            }, function(err){
                this.loading = false;
            })
        },
        filtrar: function () {
            this.loading = true;
            this.$http.post(window.baseUrl+"tarefa/filtrar", this.filtro).then(function(resp){
                this.tarefas = resp.data;
                this.loading = false;
            }, function(err){
                this.loading = false;
            })
        },
        showTarefa: function (id) {
            this.$http.get(window.baseUrl+"tarefa/show/"+id).then(function(resp){
                this.tarefa = {};
                this.tarefa = resp.data;
                $("#showTarefa").modal('show');
            }, function(resp){
            })
        },
        novaTarefa: function(){
            this.tarefa = {usuarioResponsavel:{id:""},dataLimite:moment().add(1, 'days').format('DD/MM/YYYY'), tipoTarefa:{id:""},statusTarefa:"",porcentagem:"0"};
            $("#formTarefa").modal('show');
        },
        novoLogTarefa: function(tarefa){
            this.getTarefas();
            this.tarefa = {};
            this.logTarefa = {};

            $("#showTarefa").modal('hide');
            this.$http.get(window.baseUrl+"tarefa/show/"+tarefa.id).then(function(resp){
                this.tarefa = resp.data;
                this.logTarefa = {id:"",tarefa:{"id":tarefa.id},texto:"",data:"",usuarioLog:"",porcentagem:this.tarefa.porcentagem,statusTarefa:this.tarefa.statusTarefa};
                $("#formLogTarefa").modal('show');
            }, function(resp){
            })

        },
        salvarTarefa: function(){
            this.$http.post(window.baseUrl+"tarefa/save", this.tarefa).then(function(resp){
                this.getTarefas();
                console.info(this.tarefa);
                $("#formTarefa").modal('hide');
            }, function(error){
                console.info(error)
            })
        },
        salvarLogTarefa: function(){
            this.$http.post(window.baseUrl+"logTarefa/save", this.logTarefa).then(function(resp){
                this.getTarefas();
                $("#formLogTarefa").modal('hide');
                this.showTarefa(this.logTarefa.tarefa.id)
             }, function(error){
                console.info(error)
            })
        },
        editTarefa: function(tarefa){
            $("#showTarefa").modal('hide');
            this.$http.get(window.baseUrl+"tarefa/show/"+tarefa.id).then(function(resp){
                this.tarefa = resp.data;
                $("#formTarefa").modal('show');
            }, function(resp){
            })
        },
        updateTarefa: function(){
            this.$http.put(window.baseUrl+"tarefa/update/"+this.tarefa.id, this.tarefa).then(function(resp){
                this.getTarefas();
                $("#formTarefa").modal('hide');
                this.showTarefa(this.tarefa.id);
               }, function(resp){
            })
        }
    },
    ready: function(){
        this.getTarefas();
    }
});
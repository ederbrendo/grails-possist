<div class="form-group ${invalid ? 'has-error has-feedback' : required && value ? 'has-success has-feedback' : ''}">
    <label class="col-sm-3 control-label" for="${property}">${label}</label>
    <div class="col-sm-9">
        <f:input bean="${bean}" property="${property}" class="form-control" v-model="${params.controller}.${property}"/>
        <g:if test="${invalid}">
            <span class="glyphicon glyphicon-remove form-control-feedback"></span>
            <span class="help-block">${errors.join('<br>')}</span>
        </g:if>
        <g:else test="${invalid}">
            <g:if test="${required && value}">
                <span class="glyphicon glyphicon-ok form-control-feedback"></span>
            </g:if>
        </g:else>
    </div>
</div>

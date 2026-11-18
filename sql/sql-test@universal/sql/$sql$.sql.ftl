<#list cases as case>
  <#list case.prerequisite as objVal>
    <#assign persObj = model.findObjectByName(objVal.name)>
insert into ${persObj.persistenceName} ();
  </#list>
</#list>
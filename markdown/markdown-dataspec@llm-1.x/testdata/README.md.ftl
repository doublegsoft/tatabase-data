<#import "/$/modelbase.ftl" as modelbase>
<#assign existingAttrs = {}>
我需要你结合业务特性来生成测试数据，如下：

<#list model.objects as obj>
  <#if !obj.isLabelled("persistence")><#continue></#if>
  <#list obj.attributes as attr>
    <#if !attr.isLabelled("persistence")><#continue></#if>
    <#assign attrSqlName = modelbase.get_attribute_sql_name(attr)>
    <#if existingAttrs[attrSqlName]??><#continue></#if>
    <#if attr.name?ends_with("name")>
* 生成【${modelbase.get_attribute_label(attr)}】的200条测试数据，长度不要超过${attr.constraint.maxSize}个字符，生成在当前文件夹下${attrSqlName}文件中
    <#elseif attr.type.name == "date" || attr.type.name == "datetime">
      <#if attr.name?contains("start")>      
* 生成【${modelbase.get_attribute_label(attr)}】的200条测试数据，最好是最近半年以前，一年以内的，生成在当前文件夹下${attrSqlName}文件中
      <#elseif attr.name?contains("birth")>      
* 生成【${modelbase.get_attribute_label(attr)}】的200条测试数据，最好是最近二十年以前的，生成在当前文件夹下${attrSqlName}文件中
      <#else>
* 生成【${modelbase.get_attribute_label(attr)}】的200条测试数据，最好是最近三个月以内的，生成在当前文件夹下${attrSqlName}文件中
      </#if>
    <#elseif attr.type.name == "string">
* 生成【${modelbase.get_attribute_label(attr)}】的200条测试数据，长度不要超过${attr.constraint.maxSize!"10"}个字符，生成在当前文件夹下${attrSqlName}文件中    
    </#if>
    <#assign existingAttrs += {attrSqlName: attr}>
  </#list>
</#list>  
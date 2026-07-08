<#function get_attribute_test_value attr>
  <#if attr.type.name == "number">
    <#return tatabase.number(1, 100, 0) + ".toBigDecimal()">
  <#elseif attr.type.name == "int" || attr.type.name == "integer" || attr.type.name == "long">
    <#return tatabase.number(1, 100, 0)>
  <#elseif attr.type.name == "date">
    <#return "Dates.parse(\"" + tatabase.date() + "\")">
  <#elseif attr.type.name == "time" || attr.type.name == "datetime">
    <#return "Dates.parse(\"" + tatabase.datetime() + "\")">
  <#else>
    <#return "\"" + tatabase.string(10) + "\"">
  </#if>
</#function>
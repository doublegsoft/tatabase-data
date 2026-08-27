<#--
 ###############################################################################
 ### 获取属性测试值 (Get Attribute Test Value)
 ### 
 ### 根据属性类型（attr.type.name），生成符合对应数据类型的模拟测试值。
 ### 常用于代码生成模板中，为实体属性自动填充测试数据或测试断言内容。
 ### 
 ### 类型映射规则：
 ### - "number"                  => 1到100之间的整数并追加 ".toBigDecimal()"
 ### - "int"/"integer"/"long"    => 1到100之间的随机整型或长整型数值
 ### - "date"                    => 随机日期值，并用 "Dates.parse(...)" 包裹
 ### - "time"/"datetime"         => 随机日期时间值，并用 "Dates.parse(...)" 包裹
 ### - 其他 (Default)            => 长度为 10 的随机字符串，并用双引号包裹
 ### 
 ### @param attr  目标属性对象 (Object)
 ### @return      格式化后的测试数据值字符串 (String)
 ###############################################################################
 -->
<#function get_attribute_test_value attr>
  <#if attr.type.name == "number">
    <#return tatabase.number(1, 100, 0)>
  <#elseif attr.type.name == "int" || attr.type.name == "integer" || attr.type.name == "long">
    <#return tatabase.number(1, 100, 0)>
  <#elseif attr.type.name == "date">
    <#return "'" + tatabase.date() + "'">
  <#elseif attr.type.name == "time" || attr.type.name == "datetime">
    <#return "'" + tatabase.datetime() + "'">
  <#else>
    <#return "'" + tatabase.string(10) + "'">
  </#if>
</#function>
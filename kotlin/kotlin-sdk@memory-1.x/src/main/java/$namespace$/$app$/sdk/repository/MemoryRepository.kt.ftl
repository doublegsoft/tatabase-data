<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/tatabase4kotlin.ftl" as tatabase4kotlin>
package ${namespace}.${java.nameNamespace(app.name)}.sdk.repository

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.withContext

import ${namespace}.${java.nameNamespace(app.name)}.util.*
import ${namespace}.${java.nameNamespace(app.name)}.model.*
import ${namespace}.${java.nameNamespace(app.name)}.sdk.payload.*

class MemoryRepository : Repository {
<#list model.objects as obj>

  /**
   * 【${modelbase.get_object_label(obj)}】内存数据。
   */
  private val ${java.nameVariable(obj.name)}Rows = listOf(
  <#list 1..20 as index>
    ${java.nameType(obj.name)}(
    <#list obj.attributes as attr>
      ${java.nameVariable(attr.name)} = ${tatabase4kotlin.get_attribute_test_value(attr)},
    </#list>
    ),
  </#list>
  )
</#list>  
<#list model.objects as obj>  

  /**
   * 获取【${modelbase.get_object_label(obj)}】唯一数据。
   */  
  override suspend fun fetch${java.nameType(obj.name)}(params: ${java.nameType(obj.name)}Query?): ${java.nameType(obj.name)}? {
    delay(1200)
    return ${java.nameVariable(obj.name)}Rows[0]
  }

  /**
   * 获取【${modelbase.get_object_label(obj)}】集合数据。
   */  
  override suspend fun fetch${java.nameType(inflector.pluralize(obj.name))}(params: ${java.nameType(obj.name)}Query?, start: Int, limit: Int): Pagination<${java.nameType(obj.name)}> {
    delay(1200) 
    return Pagination(${java.nameVariable(obj.name)}Rows, 100)
  }
</#list>
}
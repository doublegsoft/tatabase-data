<#assign page = pageDef>
#
# 测试【${page.title}】页面
#
goto("http://localhost:5173")

click("//nav[contains(@class, 'ef-sidebar')]//span[text()='${page.title}']")

<#----------------------->
<#-- 处理【表单输入】项目 -->
<#----------------------->
<#--  <#list page.inputs as input>
  <#if input.ancestor("excel_form")??><#continue></#if>
# ${input.title}
  <#if input.type == "date">
click("//div[@data-test='${js.nameVariable(input.id)}']")
click("//div[text()='27' and not(@disabled)]")
  <#elseif input.type == "time">
click("//div[@data-test='${js.nameVariable(input.id)}']")
click("//div[contains(@class, '${namespace}-tp__presets')]/button[text()='09:00']")
click("//div[contains(@class, '${namespace}-tp__panel')]//button[contains(@class, '${namespace}-tp__btn--ok')]")
  <#elseif input.type == "longtext">
input("//textarea[@data-test='${js.nameVariable(input.id)}']" = "${tatabase.value(input)}")
  <#elseif input.type == "select">
click("//div[@data-test='${js.nameVariable(input.id)}']/button")
click("(//div[contains(@class, '${namespace}-dd-panel')]//div[contains(@class, '${namespace}-dd-option')])[1]")
  <#elseif input.type == "multiselect">
click("//div[@data-test='${js.nameVariable(input.id)}']/div")
click("(//div[contains(@class, '${namespace}-ms__panel')]//div[contains(@class, '${namespace}-ms__option')])[1]")
click("(//div[contains(@class, '${namespace}-ms__panel')]//div[contains(@class, '${namespace}-ms__option')])[2]")
click("//div[@data-test='${js.nameVariable(input.id)}']/div")
  <#else>
input("//input[@data-test='${js.nameVariable(input.id)}']" = "${tatabase.value(input)}")
  </#if>
</#list>  -->

<#-------------------------------------------->
<#-- 如果存在excel form，则处理excel form的编辑 -->
<#-------------------------------------------->
<#list page.widgets as widget>
  <#if widget.type != "excel_form"><#continue></#if>
  <#if widget.ancestor("tab")??>
    <#assign tab = widget.ancestor("tab")>
click("//div[contains(@class, '${namespace}-tabs')]//span[text()='${tab.title}']")
  </#if>
  <#list widget.inputs as input>  
  </#list>
dblclick("//tbody/tr[5]/td[3]//span")  
dblclick("//tbody/tr[5]/td[3]//span")
</#list>

sleep("30")
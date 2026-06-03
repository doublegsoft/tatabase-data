<#assign page = pageDef>
goto("http://localhost:5173")

<#--  click("//div[contains(@class, 'ef-tnav') and text()='${modules[page.module]}']")  -->
click("//nav[contains(@class, 'ef-sidebar')]//span[text()='${page.title}']")

<#list page.inputs as input>
# ${input.title}
  <#if input.type == 'date'>
click("//div[@data-test='${js.nameVariable(input.id)}']")
click("//button[text()='27' and not(@disabled)]")
  <#elseif input.type == 'longtext'>
input("//textarea[@data-test='${js.nameVariable(input.id)}']" = "${tatabase.value(input)}")
  <#else>
input("//input[@data-test='${js.nameVariable(input.id)}']" = "${tatabase.value(input)}")
  </#if>
</#list>

sleep("30")
<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/tatabase4js.ftl" as tatabase4js>
<#macro print_input_value input indent>
  <#if (input.type!"") == "date">
${""?left_pad(indent)}${js.nameVariable(input.id)}: '${tatabase.date()}',
  <#elseif (input.type!"") == "number">
${""?left_pad(indent)}${js.nameVariable(input.id)}: '${tatabase.number(1, 100)}',
  <#elseif (input.type!"") == "select">
    <#if input.value("data")?starts_with("enum[")>
${""?left_pad(indent)}${js.nameVariable(input.id)}: '${tatabase.enumcode(input.value("data"))}',
    <#else>
${""?left_pad(indent)}${js.nameVariable(input.id)}: 'DEF',
    </#if>
  <#elseif (input.type!"") == "multiselect">
${""?left_pad(indent)}${js.nameVariable(input.id)}: ['ABC','DEF','EFG'],
  <#elseif (input.type!"") == "tags">
${""?left_pad(indent)}${js.nameVariable(input.id)}: ['${tatabase.string(10)}','${tatabase.string(10)}','${tatabase.string(10)}'],
  <#elseif (input.type!"") == "avatar">
${""?left_pad(indent)}${js.nameVariable(input.id)}: '${tatabase.avatar()}',
  <#elseif (input.type!"") == "images">
${""?left_pad(indent)}${js.nameVariable(input.id)}: [{
${""?left_pad(indent)}  id: '${tatabase.number(1, 100, 0)}', url: '${tatabase.image()}',
${""?left_pad(indent)}},{
${""?left_pad(indent)}  id: '${tatabase.number(1, 100, 0)}', url: '${tatabase.image()}',
${""?left_pad(indent)}},{
${""?left_pad(indent)}  id: '${tatabase.number(1, 100, 0)}', url: '${tatabase.image()}',
${""?left_pad(indent)}],
  <#elseif (input.type!"") == "files" || (input.type!"") == "videos">
${""?left_pad(indent)}${js.nameVariable(input.id)}: [{
${""?left_pad(indent)}  id: '${tatabase.number(1, 100, 0)}', url: '${tatabase.string(10)}',
${""?left_pad(indent)}},{
${""?left_pad(indent)}  id: '${tatabase.number(1, 100, 0)}', url: '${tatabase.string(10)}',
${""?left_pad(indent)}},{
${""?left_pad(indent)}  id: '${tatabase.number(1, 100, 0)}', url: '${tatabase.string(10)}',
${""?left_pad(indent)}],
  <#elseif (input.type!"") == "time">
${""?left_pad(indent)}${js.nameVariable(input.id)}: '10:10',
  <#else>
${""?left_pad(indent)}${js.nameVariable(input.id)}: '${tatabase.string(10)}',
  </#if>
</#macro>
let sdk
if (typeof sdk === 'undefined') {
  sdk = {};
}
<#assign visited_resources = {}>
<#list app.pages as page>
  <#list page.widgets as widget>
    <#if !widget.id??><#continue></#if>
    <#assign url = valuebase.url(widget.value("data", widget.id))>
    <#assign objname = url.resource>
    <#if objname?starts_with("$")><#continue></#if><#-- 引用数据，忽略 -->
    <#if (widget.type == "select" || widget.type == "multiselect") &&
         widget.value("data","")?starts_with("enum[") &&
         typebase.enumtype(widget.value("data"))?size == 1>
      <#assign opt = typebase.enumtype(widget.value("data"))?first>
      <#if visited_resources[opt.name + "Options"]??><#continue></#if>
      <#assign visited_resources += {opt.name + "Options":opt.name}>

sdk.fetch${js.nameType(inflector.pluralize(opt.name))}AsOptions = async () => {
  await new Promise(r => setTimeout(r, 300 + Math.random() * 300))
  return [{
    ${js.nameVariable(opt.code)}: '10', ${js.nameVariable(opt.text)}: '${tatabase.string(5)}',
  },{
    ${js.nameVariable(opt.code)}: '20', ${js.nameVariable(opt.text)}: '${tatabase.string(5)}',
  },{
    ${js.nameVariable(opt.code)}: '30', ${js.nameVariable(opt.text)}: '${tatabase.string(5)}',
  },{
    ${js.nameVariable(opt.code)}: '40', ${js.nameVariable(opt.text)}: '${tatabase.string(5)}',
  },{
    ${js.nameVariable(opt.code)}: '50', ${js.nameVariable(opt.text)}: '${tatabase.string(5)}',
  },{
    ${js.nameVariable(opt.code)}: '60', ${js.nameVariable(opt.text)}: '${tatabase.string(5)}',
  },{
    ${js.nameVariable(opt.code)}: '70', ${js.nameVariable(opt.text)}: '${tatabase.string(5)}',
  }];
};
    <#elseif widget.type == "cascade" &&
             widget.value("data","")?starts_with("enum[") &&
             typebase.enumtype(widget.value("data"))?size == 1>
      <#assign opt = typebase.enumtype(widget.value("data"))?first>
      <#if visited_resources[opt.name + "Options"]??><#continue></#if>
      <#assign visited_resources += {opt.name + "Options":opt.name}>

sdk.fetch${js.nameType(inflector.pluralize(opt.name))}AsOptions = async (parentValue) => {
  await new Promise(r => setTimeout(r, 300 + Math.random() * 300))
  return [{
    ${js.nameVariable(opt.code)}: '10', ${js.nameVariable(opt.text)}: '${tatabase.string(5)}',
  },{
    ${js.nameVariable(opt.code)}: '20', ${js.nameVariable(opt.text)}: '${tatabase.string(5)}',
  },{
    ${js.nameVariable(opt.code)}: '30', ${js.nameVariable(opt.text)}: '${tatabase.string(5)}',
  },{
    ${js.nameVariable(opt.code)}: '40', ${js.nameVariable(opt.text)}: '${tatabase.string(5)}',
  },{
    ${js.nameVariable(opt.code)}: '50', ${js.nameVariable(opt.text)}: '${tatabase.string(5)}',
  },{
    ${js.nameVariable(opt.code)}: '60', ${js.nameVariable(opt.text)}: '${tatabase.string(5)}',
  },{
    ${js.nameVariable(opt.code)}: '70', ${js.nameVariable(opt.text)}: '${tatabase.string(5)}',
  }];
}
    <#elseif widget.type == "entry_form" || widget.type == "display_form">
      <#if visited_resources[objname]??><#continue></#if>
      <#assign visited_resources += {objname:objname}>

sdk.fetch${js.nameType(objname)} = async (params) => {
  return {
      <#list widget.children as child>
<@print_input_value input=child indent=4 />
      </#list>    
  }
};

    <#elseif widget.type == "paged_table" || widget.type == "fixed_table" || 
             widget.type == "excel_form" || widget.type == "paged_grid" ||
             widget.type == "time_grid" || widget.type == "list_view" ||
             widget.type == "grid_view" || widget.type == "split_list">
      <#if visited_resources[inflector.pluralize(objname)]??><#continue></#if>
      <#assign visited_resources += {inflector.pluralize(objname):objname}>

sdk.fetch${js.nameType(inflector.pluralize(objname))} = async (params, start, limit) => {
  return {
    total: 100,
    data: [{
      <#list 1..20 as i>      
        <#if i != 1>
    },{
       </#if>
        <#list widget.children as child>
          <#if !child.id??><#continue></#if>
          <#if child.type == "date">
      ${js.nameVariable(child.id)}: '${tatabase.date()}',  
          <#elseif child.type == "number">
      ${js.nameVariable(child.id)}: '${tatabase.number(1, 100)}',  
          <#elseif child.type == "select">
      ${js.nameVariable(child.id)}: 'DEF',  
          <#elseif child.type == "multiselect">
      ${js.nameVariable(child.id)}: ['ABC', 'DEF', 'EFG'],  
          <#else>
      ${js.nameVariable(child.id)}: '${tatabase.string(10)}',
          </#if>
        </#list>    
      </#list>  
    }]
  };
};
      <#assign group = widget.value("group")>
      <#if group != "">
        <#assign groupRes = valuebase.url(group)>
        <#if visited_resources[inflector.pluralize(groupRes.resource)]??><#continue></#if>
        <#assign visited_resources += {inflector.pluralize(groupRes.resource):objname}>

sdk.fetch${js.nameType(inflector.pluralize(groupRes.resource))} = async (params, start, limit) => {
  return {
    total: 10,
    data: [{
      <#list 1..10 as i>      
        <#if i != 1>
    },{
       </#if>
      ${js.nameVariable(groupRes.resource)}Id: '${i?string}',   
      ${js.nameVariable(groupRes.resource)}Name: '${tatabase.string(10)}',  
      </#list>  
    }]
  };
};
      </#if>
    <#elseif widget.type == "chart">

sdk.fetch${js.nameType(inflector.pluralize(objname))} = async (params, start, limit) => {
  return {
    total: 24,
    data: [
      { month: '1月',  category: '居民用电',   amount: 320 },
      { month: '1月',  category: '工商业用电', amount: 180 },
      { month: '2月',  category: '居民用电',   amount: 280 },
      { month: '2月',  category: '工商业用电', amount: 190 },
      { month: '3月',  category: '居民用电',   amount: 260 },
      { month: '3月',  category: '工商业用电', amount: 210 },
      { month: '4月',  category: '居民用电',   amount: 240 },
      { month: '4月',  category: '工商业用电', amount: 230 },
      { month: '5月',  category: '居民用电',   amount: 250 },
      { month: '5月',  category: '工商业用电', amount: 250 },
      { month: '6月',  category: '居民用电',   amount: 310 },
      { month: '6月',  category: '工商业用电', amount: 270 },
      { month: '7月',  category: '居民用电',   amount: 420 },
      { month: '7月',  category: '工商业用电', amount: 300 },
      { month: '8月',  category: '居民用电',   amount: 480 },
      { month: '8月',  category: '工商业用电', amount: 310 },
      { month: '9月',  category: '居民用电',   amount: 380 },
      { month: '9月',  category: '工商业用电', amount: 280 },
      { month: '10月', category: '居民用电',   amount: 300 },
      { month: '10月', category: '工商业用电', amount: 260 },
      { month: '11月', category: '居民用电',   amount: 290 },
      { month: '11月', category: '工商业用电', amount: 240 },
      { month: '12月', category: '居民用电',   amount: 340 },
      { month: '12月', category: '工商业用电', amount: 200 },
    ]
  };
};    
    </#if>
  </#list>
  <#if page.value("data") != ""><#-- 页面定义的数据来源 -->
    <#assign url = valuebase.url(page.value("data"))>
    <#if visited_resources[url.resource]??><#continue></#if>
    <#assign visited_resources += {url.resource:url.resource}>

sdk.fetch${js.nameType(url.resource)} = async (params) => {
  return {
    <#list page.widgets as widget>
      <#if !widget.value("data")?starts_with("$" + url.resource)><#continue></#if>
      <#list widget.children as child>
<@print_input_value input=child indent=4 />
      </#list>
    </#list>
  };
};
  </#if>
</#list>
<#list model.objects as obj>
  <#if visited_resources[obj.name]??><#continue></#if>
  <#assign visited_resources += {obj.name:objname}>

sdk.fetch${js.nameType(obj.name)} = async (params) => {
  return {
  <#list obj.attributes as attr>
    ${modelbase.get_attribute_sql_name(attr)}: ${tatabase4js.get_attribute_test_value(attr)},
  </#list>    
  };
};
  <#if visited_resources[modelbase.get_object_plural(obj)]??><#continue></#if>
  <#assign visited_resources += {modelbase.get_object_plural(obj):obj.name}>

sdk.fetch${js.nameType(modelbase.get_object_plural(obj))} = async (params) => {
  return {
    total: 100,
    data: [{
  <#list 1..20 as idx>
    <#if idx != 1>
    },{  
    </#if>
    <#list obj.attributes as attr>
      ${modelbase.get_attribute_sql_name(attr)}: ${tatabase4js.get_attribute_test_value(attr)},
    </#list>    
  </#list>    
    }]
  };
};
</#list>
export default sdk
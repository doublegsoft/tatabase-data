let sdk
if (typeof sdk === 'undefined') {
  sdk = {};
}
<#assign visited_widgets = {}>
<#list app.pages as page>
  <#list page.widgets as widget>
    <#if !widget.id?? || visited_widgets[widget.id]??><#continue></#if>
    <#assign objname = widget.value("object", widget.id)>
    <#assign visited_widgets += {objname: widget}>
    <#if (widget.type == "select" || widget.type == "multiselect")>
      <#if !widget.value("data","")?starts_with("enum[")>

sdk.fetch${js.nameType(inflector.pluralize(widget.value("object",widget.id)))}AsOptions = async () => {
  return [{
    value: 'ABC', label: '${tatabase.string(5)}',
  },{
    value: 'BCD', label: '${tatabase.string(5)}',
  },{
    value: 'CDE', label: '${tatabase.string(5)}',
  },{
    value: 'DEF', label: '${tatabase.string(5)}',
  },{
    value: 'EFG', label: '${tatabase.string(5)}',
  },{
    value: 'FGH', label: '${tatabase.string(5)}',
  },{
    value: 'GHI', label: '${tatabase.string(5)}',
  }];
};
      </#if>
    <#elseif widget.type == "cascade">

// 级联数据：按父节点逐级获取（模拟真实 API 逐级调用）
sdk.${js.nameVariable(widget.value("object",widget.id))}Options = {
  _root: [
    { value: 'bj', label: '北京市',     hasChildren: true },
    { value: 'sh', label: '上海市',     hasChildren: true },
    { value: 'gd', label: '广东省',     hasChildren: true },
    { value: 'zj', label: '浙江省',     hasChildren: true },
  ],
  bj: [
    { value: 'hd',   label: '海淀区',   hasChildren: true },
    { value: 'cy',   label: '朝阳区',   hasChildren: true },
    { value: 'dc',   label: '东城区',   hasChildren: false },
    { value: 'xc',   label: '西城区',   hasChildren: false },
  ],
  hd: [
    { value: 'zgc',  label: '中关村',   hasChildren: false },
    { value: 'wdk',  label: '五道口',   hasChildren: false },
    { value: 'shdi', label: '上地',     hasChildren: false },
  ],
  cy: [
    { value: 'cbd',  label: 'CBD',      hasChildren: false },
    { value: 'sl',   label: '三里屯',   hasChildren: false },
  ],
  sh: [
    { value: 'pd',   label: '浦东新区', hasChildren: true },
    { value: 'hp',   label: '黄浦区',   hasChildren: false },
    { value: 'xh',   label: '徐汇区',   hasChildren: false },
  ],
  pd: [
    { value: 'ljz',  label: '陆家嘴',   hasChildren: false },
    { value: 'zj',   label: '张江',     hasChildren: false },
  ],
  gd: [
    { value: 'gz',   label: '广州市',   hasChildren: true },
    { value: 'sz',   label: '深圳市',   hasChildren: true },
  ],
  gz: [
    { value: 'th',   label: '天河区',   hasChildren: false },
    { value: 'yx',   label: '越秀区',   hasChildren: false },
  ],
  sz: [
    { value: 'ns',   label: '南山区',   hasChildren: false },
    { value: 'ft',   label: '福田区',   hasChildren: false },
  ],
  zj: [
    { value: 'hz',   label: '杭州市',   hasChildren: false },
    { value: 'nb',   label: '宁波市',   hasChildren: false },
  ],
}

sdk.fetch${js.nameType(widget.value("object",widget.id))}AsOptions = async (parentValue) => {
  await new Promise(r => setTimeout(r, 300 + Math.random() * 300))
  const key = parentValue === null || parentValue === undefined ? '_root' : String(parentValue)
  return sdk.${js.nameVariable(widget.value("object",widget.id))}Options[key] || []
}
    <#elseif widget.type == "entry_form" || widget.type == "display_form">

sdk.fetch${js.nameType(objname)} = async (start, limit) => {
  return {
      <#list widget.children as col>
        <#if col.type == "date">
    ${js.nameVariable(col.id)}: '${tatabase.date()}',  
        <#elseif col.type == "number">
    ${js.nameVariable(col.id)}: '${tatabase.number(1, 100)}',  
        <#else>
    ${js.nameVariable(col.id)}: '${tatabase.string(10)}',
        </#if>
      </#list>    
  }
};

    <#elseif widget.type == "paged_table" || widget.type == "fixed_table" || widget.type == "excel_form">

sdk.fetch${js.nameType(inflector.pluralize(objname))} = async (params, start, limit) => {
  return {
    total: 100,
    data: [{
      <#list 1..20 as i>      
        <#if i != 1>
    },{
       </#if>
        <#list widget.children as col>
          <#if !col.id??><#continue></#if>
          <#if col.type == "date">
      ${js.nameVariable(col.id)}: '${tatabase.date()}',  
          <#elseif col.type == "number">
      ${js.nameVariable(col.id)}: '${tatabase.number(1, 100)}',  
          <#else>
      ${js.nameVariable(col.id)}: '${tatabase.string(10)}',
          </#if>
        </#list>    
      </#list>  
    }]
  };
};
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
</#list>
    
export default sdk
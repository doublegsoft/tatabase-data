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

sdk.fetch${js.nameType(inflector.pluralize(objname))}Options = async () => {
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

sdk.fetch${js.nameType(widget.id)}Options = async () => {    
  return [{ 
    value: 'bj', label: '北京市', 
    children: [{ 
      value: 'hd', label: '海淀区', 
      children: [{ 
        value: 'zgc', label: '中关村' 
      },{ 
        value: 'wdk', label: '五道口' 
      },{ 
        value: 'shdi', label: '上地' 
      }]
    },{ 
      value: 'cy', label: '朝阳区', 
      children: [{ 
        value: 'cbd', label: 'CBD' 
      },{ 
        value: 'sl', label: '三里屯' 
      }]
    },{ 
      value: 'dc', label: '东城区' 
    },{ 
      value: 'xc', label: '西城区' 
    }]
  },{ 
    value: 'sh', label: '上海市', 
    children: [{ 
      value: 'pd', label: '浦东新区', 
      children: [{ 
        value: 'ljz', label: '陆家嘴'
      },{ 
        value: 'zj', label: '张江' 
      }]
    },{ 
      value: 'hp', label: '黄浦区' 
    },{ 
      value: 'xh', label: '徐汇区' 
    }]
  },{ 
    value: 'gd', label: '广东省', 
    children: [{ 
      value: 'gz', label: '广州市', 
      children: [{ 
        value: 'th', label: '天河区' 
      },{ 
        value: 'yx', label: '越秀区' 
      }]
    },{ 
      value: 'sz', label: '深圳市', 
      children: [{ 
        value: 'ns', label: '南山区' 
      },{ 
        value: 'ft', label: '福田区' 
      }]
    }]
  },{ 
    value: 'zj', label: '浙江省', 
    children: [{ 
      value: 'hz', label: '杭州市' 
    },{ 
      value: 'nb', label: '宁波市' 
    }]
  }];
};
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
    </#if>
  </#list>
</#list>
    
export default sdk
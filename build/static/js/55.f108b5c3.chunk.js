(window.webpackJsonp=window.webpackJsonp||[]).push([[55],{1019:function(e,t,a){"use strict";var n=a(35),r=a(100),o=a(896),i=a(63),s=a(3),l=a.n(s),c=a(112),d=a.n(c),u=a(886),f=a.n(u),m=a(887),p={children:d.a.node,inline:d.a.bool,tag:m.p,innerRef:d.a.oneOfType([d.a.object,d.a.func,d.a.string]),className:d.a.string,cssModule:d.a.object},v=function(e){function t(t){var a;return(a=e.call(this,t)||this).getRef=a.getRef.bind(Object(o.a)(a)),a.submit=a.submit.bind(Object(o.a)(a)),a}Object(i.a)(t,e);var a=t.prototype;return a.getRef=function(e){this.props.innerRef&&this.props.innerRef(e),this.ref=e},a.submit=function(){this.ref&&this.ref.submit()},a.render=function(){var e=this.props,t=e.className,a=e.cssModule,o=e.inline,i=e.tag,s=e.innerRef,c=Object(r.a)(e,["className","cssModule","inline","tag","innerRef"]),d=Object(m.l)(f()(t,!!o&&"form-inline"),a);return l.a.createElement(i,Object(n.a)({},c,{ref:s,className:d}))},t}(s.Component);v.propTypes=p,v.defaultProps={tag:"form"},t.a=v},1439:function(e,t,a){"use strict";a.r(t);var n=a(962),r=a(963),o=a.n(r),i=a(964),s=a(228),l=a(229),c=a(231),d=a(230),u=a(233),f=a(232),m=a(3),p=a.n(m),v=(a(1014),a(1073)),h=a(910),b=a(905),g=a(912),y=a(925),C=a(913),N=a(1019),E=a(1040),S=a(990),j=a(978),O=a(979),x=a(947),w=a.n(x),R=a(991),k=(a(1026),function(e){function t(e){var a;return Object(s.a)(this,t),(a=Object(c.a)(this,Object(d.a)(t).call(this,e))).adddriver=Object(i.a)(o.a.mark(function e(){return o.a.wrap(function(e){for(;;)switch(e.prev=e.next){case 0:return e.next=2,w.a.post("/adddriver",{driverLicenseNo:a.state.driverLicenseNo,driverName:a.state.driverName,driverContact:a.state.driverContact}).then(function(e){e.data.status.localeCompare("Successfull")?alert("Bad Credentials"):(alert("Successfully Added"),a.getDrivers())});case 2:case"end":return e.stop()}},e)})),a.updateDriver=Object(i.a)(o.a.mark(function e(){return o.a.wrap(function(e){for(;;)switch(e.prev=e.next){case 0:return e.next=2,w.a.post("/updatedriver",{driverLicenseNo:a.state.driverLicenseNo,driverName:a.state.driverName,driverContact:a.state.driverContact}).then(function(e){e.data.status.localeCompare("Successfull")?alert("Bad Credentials"):(alert("Successfully Updated"),a.getDrivers())});case 2:case"end":return e.stop()}},e)})),a.onRowSelect=function(e){a.setState({driverLicenseNo:e.driverLicenseNo,driverContact:e.driverContact,driverName:e.driverName,btnText:"Update",btnColor:"info",liceStatus:!0})},a.onAfterDeleteRow=function(e){w.a.post("/deletedriver",{driverLicenseNo:e}).then(function(e){e.data.status.localeCompare("Successfull")?alert("Failed"):(alert("Successfully Deleted"),a.getDrivers())})},a.options={afterDeleteRow:a.onAfterDeleteRow},a.selectRowProp={mode:"radio",onSelect:a.onRowSelect,bgColor:"yellow"},a.clearForm=function(){a.setState({driverLicenseNo:"",driverContact:"",driverName:"",btnText:"Save",btnColor:"dark",liceStatus:!1})},a.handleSave=function(){a.state.btnText.localeCompare("Save")?a.updateDriver():a.adddriver()},a.toggle=a.toggle.bind(Object(u.a)(a)),a.toggleFade=a.toggleFade.bind(Object(u.a)(a)),a.state={collapse:!0,fadeIn:!0,timeout:300,driverLicenseNo:"",driverContact:"",driverName:"",drivers:[],btnText:"Save",btnColor:"dark",liceStatus:!1},a.onChange=a.onChange.bind(Object(u.a)(a)),a.onSubmit=a.onSubmit.bind(Object(u.a)(a)),a}return Object(f.a)(t,e),Object(l.a)(t,[{key:"componentDidMount",value:function(){this.getDrivers()}},{key:"onChange",value:function(e){this.setState(Object(n.a)({},e.target.name,e.target.value))}},{key:"onSubmit",value:function(e){e.preventDefault(),this.state.btnText.localeCompare("Save")?this.updateLorry():this.addLorry()}},{key:"toggle",value:function(){this.setState({collapse:!this.state.collapse})}},{key:"toggleFade",value:function(){this.setState(function(e){return{fadeIn:!e}})}},{key:"getDrivers",value:function(){var e=this;fetch("/getdrivers").then(function(e){return e.json()}).then(function(t){e.setState({drivers:t})})}},{key:"render",value:function(){return p.a.createElement("div",{className:"animated fadeIn"},p.a.createElement(v.a,null,p.a.createElement(h.a,null,p.a.createElement(b.a,{xs:"12",sm:"6"},p.a.createElement(g.a,null,p.a.createElement(y.a,null,p.a.createElement("strong",null,"Drivers")),p.a.createElement(C.a,null,p.a.createElement(N.a,{onSubmit:this.onSubmit},p.a.createElement(E.a,{row:!0}),p.a.createElement(E.a,null,p.a.createElement(S.a,{htmlFor:"name"},"Driver Name"),p.a.createElement(j.a,{type:"text",name:"driverName",value:this.state.driverName,onChange:this.onChange})),p.a.createElement(E.a,null,p.a.createElement(S.a,{htmlFor:"liscence"},"Liscence No"),p.a.createElement(j.a,{type:"text",name:"driverLicenseNo",disabled:this.state.liceStatus,value:this.state.driverLicenseNo,onChange:this.onChange})),p.a.createElement(E.a,null,p.a.createElement(S.a,{htmlFor:"contact"},"Contact"),p.a.createElement(j.a,{type:"text",name:"driverContact",value:this.state.driverContact,onChange:this.onChange})),p.a.createElement(E.a,{row:!0,className:"my-0"},p.a.createElement(b.a,{xs:"6"},p.a.createElement(E.a,null,p.a.createElement(O.a,{block:!0,color:this.state.btnColor,onClick:this.handleSave},this.state.btnText))),p.a.createElement(b.a,{xs:"6"},p.a.createElement(E.a,null,p.a.createElement(O.a,{block:!0,color:"dark",onClick:this.clearForm},"clear")))))))),p.a.createElement(b.a,{xs:"12",sm:"6"},p.a.createElement(g.a,null,p.a.createElement(C.a,{style:{backgroundColor:"#d9d9d9"}},p.a.createElement("div",null,p.a.createElement(R.BootstrapTable,{data:this.state.drivers,height:"310",scrollTop:"Bottom",deleteRow:!0,selectRow:this.selectRowProp,options:this.options,search:!0,tableStyle:{border:"#0000FF 2.5px solid"},containerStyle:{border:"#FFBB73 2.5px solid"},headerStyle:{border:"red 1px solid"},bodyStyle:{border:"green 1px solid"}},p.a.createElement(R.TableHeaderColumn,{width:"120",dataField:"driverLicenseNo",isKey:!0},"Licence No"),p.a.createElement(R.TableHeaderColumn,{width:"110",dataField:"driverName"},"Driver"),p.a.createElement(R.TableHeaderColumn,{width:"140",dataField:"driverContact"},"Contact")))))))))}}]),t}(m.Component));t.default=k},978:function(e,t,a){"use strict";var n=a(35),r=a(100),o=a(896),i=a(63),s=a(3),l=a.n(s),c=a(112),d=a.n(c),u=a(886),f=a.n(u),m=a(887),p={children:d.a.node,type:d.a.string,size:d.a.string,bsSize:d.a.string,valid:d.a.bool,invalid:d.a.bool,tag:m.p,innerRef:d.a.oneOfType([d.a.object,d.a.func,d.a.string]),plaintext:d.a.bool,addon:d.a.bool,className:d.a.string,cssModule:d.a.object},v=function(e){function t(t){var a;return(a=e.call(this,t)||this).getRef=a.getRef.bind(Object(o.a)(a)),a.focus=a.focus.bind(Object(o.a)(a)),a}Object(i.a)(t,e);var a=t.prototype;return a.getRef=function(e){this.props.innerRef&&this.props.innerRef(e),this.ref=e},a.focus=function(){this.ref&&this.ref.focus()},a.render=function(){var e=this.props,t=e.className,a=e.cssModule,o=e.type,i=e.bsSize,s=e.valid,c=e.invalid,d=e.tag,u=e.addon,p=e.plaintext,v=e.innerRef,h=Object(r.a)(e,["className","cssModule","type","bsSize","valid","invalid","tag","addon","plaintext","innerRef"]),b=["radio","checkbox"].indexOf(o)>-1,g=new RegExp("\\D","g"),y=d||("select"===o||"textarea"===o?o:"input"),C="form-control";p?(C+="-plaintext",y=d||"input"):"file"===o?C+="-file":b&&(C=u?null:"form-check-input"),h.size&&g.test(h.size)&&(Object(m.r)('Please use the prop "bsSize" instead of the "size" to bootstrap\'s input sizing.'),i=h.size,delete h.size);var N=Object(m.l)(f()(t,c&&"is-invalid",s&&"is-valid",!!i&&"form-control-"+i,C),a);return("input"===y||d&&"function"===typeof d)&&(h.type=o),h.children&&!p&&"select"!==o&&"string"===typeof y&&"select"!==y&&(Object(m.r)('Input with a type of "'+o+'" cannot have children. Please use "value"/"defaultValue" instead.'),delete h.children),l.a.createElement(y,Object(n.a)({},h,{ref:v,className:N}))},t}(l.a.Component);v.propTypes=p,v.defaultProps={type:"text"},t.a=v},990:function(e,t,a){"use strict";var n=a(35),r=a(100),o=a(3),i=a.n(o),s=a(112),l=a.n(s),c=a(886),d=a.n(c),u=a(894),f=a.n(u),m=a(887),p=l.a.oneOfType([l.a.number,l.a.string]),v=l.a.oneOfType([l.a.string,l.a.number,l.a.shape({size:p,order:p,offset:p})]),h={children:l.a.node,hidden:l.a.bool,check:l.a.bool,size:l.a.string,for:l.a.string,tag:m.p,className:l.a.string,cssModule:l.a.object,xs:v,sm:v,md:v,lg:v,xl:v,widths:l.a.array},b={tag:"label",widths:["xs","sm","md","lg","xl"]},g=function(e,t,a){return!0===a||""===a?e?"col":"col-"+t:"auto"===a?e?"col-auto":"col-"+t+"-auto":e?"col-"+a:"col-"+t+"-"+a},y=function(e){var t=e.className,a=e.cssModule,o=e.hidden,s=e.widths,l=e.tag,c=e.check,u=e.size,p=e.for,v=Object(r.a)(e,["className","cssModule","hidden","widths","tag","check","size","for"]),h=[];s.forEach(function(t,n){var r=e[t];if(delete v[t],r||""===r){var o,i=!n;if(f()(r)){var s,l=i?"-":"-"+t+"-";o=g(i,t,r.size),h.push(Object(m.l)(d()(((s={})[o]=r.size||""===r.size,s["order"+l+r.order]=r.order||0===r.order,s["offset"+l+r.offset]=r.offset||0===r.offset,s))),a)}else o=g(i,t,r),h.push(o)}});var b=Object(m.l)(d()(t,!!o&&"sr-only",!!c&&"form-check-label",!!u&&"col-form-label-"+u,h,!!h.length&&"col-form-label"),a);return i.a.createElement(l,Object(n.a)({htmlFor:p},v,{className:b}))};y.propTypes=h,y.defaultProps=b,t.a=y}}]);
//# sourceMappingURL=55.f108b5c3.chunk.js.map
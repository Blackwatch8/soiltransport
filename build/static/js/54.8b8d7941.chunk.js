(window.webpackJsonp=window.webpackJsonp||[]).push([[54],{1079:function(e,t,a){"use strict";var n=a(35),l=a(100),r=a(3),o=a.n(r),c=a(112),i=a.n(c),s=a(886),d=a.n(s),u=a(887),p={tag:u.p,className:i.a.string,cssModule:i.a.object},m=function(e){var t=e.className,a=e.cssModule,r=e.tag,c=Object(l.a)(e,["className","cssModule","tag"]),i=Object(u.l)(d()(t,"card-footer"),a);return o.a.createElement(r,Object(n.a)({},c,{className:i}))};m.propTypes=p,m.defaultProps={tag:"div"},t.a=m},1467:function(e,t,a){"use strict";a.r(t);var n=a(1001),l=a(1002),r=a.n(l),o=a(1003),c=a(228),i=a(229),s=a(231),d=a(230),u=a(233),p=a(232),m=a(3),f=a.n(m),h=a(1066),y=a(1127),g=a(936),D=a(937),v=a(946),b=a(951),w=a(1208),E=a(947),S=a(1079),F=a(1277),C=a(987),N=a.n(C),A=a(1081),P=a(1169),O=a(1086),T=a(948),k=a(1173),j=a(1068),M=a(236),x=a.n(M),B=a(1080),R=a.n(B),U=function(e){function t(e){var a;return Object(c.a)(this,t),(a=Object(s.a)(this,Object(d.a)(t).call(this,e))).getDeliveries=Object(o.a)(r.a.mark(function e(){var t,n;return r.a.wrap(function(e){for(;;)switch(e.prev=e.next){case 0:return t=a.state.startDate.getFullYear()+"-"+(a.state.startDate.getMonth()+1)+"-"+a.state.startDate.getDate(),n=a.state.endDate.getFullYear()+"-"+(a.state.endDate.getMonth()+1)+"-"+a.state.endDate.getDate(),e.next=4,N.a.post("/updatedelitable",{startDate:t,endDate:n}).then(function(e){a.setState({deliveries:e.data})});case 4:case"end":return e.stop()}},e)})),a.loading=function(){return f.a.createElement("div",{className:"animated fadeIn pt-1 text-center"},"Loading...")},a.handleClick=function(){console.log("Click happened")},a.getPayments=Object(o.a)(r.a.mark(function e(){var t,n,l,o;return r.a.wrap(function(e){for(;;)switch(e.prev=e.next){case 0:return t=a.state.startDate.getFullYear()+"-"+(a.state.startDate.getMonth()+1)+"-"+a.state.startDate.getDate(),n=a.state.endDate.getFullYear()+"-"+(a.state.endDate.getMonth()+1)+"-"+a.state.endDate.getDate(),e.next=4,N.a.post("/getdailypayments",{startDate:t,endDate:n}).then(function(e){a.setState({payments:e.data})});case 4:for(l=0,o=0;o<a.state.payments.length;o++)l+=a.state.payments[o].paymentsAmount;a.setState({payTotal:l});case 7:case"end":return e.stop()}},e)})),a.onCellBButtonDouClick=function(){var e=Object(o.a)(r.a.mark(function e(t,n){return r.a.wrap(function(e){for(;;)switch(e.prev=e.next){case 0:t.localeCompare("Accepted")||N.a.post("/updateacceptance",{deliveryAcceptance:"Rejected",deliveryNoteNO:n.deliveryNoteNO}).then(function(e){e.data.status.localeCompare("SuccessfullyAdded")?R.a.fire("Failed !","","error"):a.getDeliveries()});case 1:case"end":return e.stop()}},e)}));return function(t,a){return e.apply(this,arguments)}}(),a.handleStartDateChange=function(e){a.setState({startDate:e},function(){a.getDeliveries(),a.getPayments()})},a.handleEndDateChange=function(e){a.setState({endDate:e},function(){a.getDeliveries(),a.getPayments()})},a.createAndDownloadDeliveryPdf=Object(o.a)(r.a.mark(function e(){var t,n;return r.a.wrap(function(e){for(;;)switch(e.prev=e.next){case 0:return a.setState({showAni:!0}),t=a.state.startDate.getFullYear()+"-"+(a.state.startDate.getMonth()+1)+"-"+a.state.startDate.getDate(),n=a.state.endDate.getFullYear()+"-"+(a.state.endDate.getMonth()+1)+"-"+a.state.endDate.getDate(),e.next=5,N.a.post("/getDailyDeliveryReport",{deliveries:a.state.deliveries,startDate:t,endDate:n}).then(function(){return N.a.get("/fetch-pdf",{responseType:"blob"})}).then(function(e){var t=new Blob([e.data],{type:"application/pdf"});Object(j.saveAs)(t,"DailyDeliveries.pdf")});case 5:a.setState({showAni:!1});case 6:case"end":return e.stop()}},e)})),a.createAndDownloadPaymentPdf=Object(o.a)(r.a.mark(function e(){var t,n;return r.a.wrap(function(e){for(;;)switch(e.prev=e.next){case 0:return a.setState({showAni:!0}),t=a.state.startDate.getFullYear()+"-"+(a.state.startDate.getMonth()+1)+"-"+a.state.startDate.getDate(),n=a.state.endDate.getFullYear()+"-"+(a.state.endDate.getMonth()+1)+"-"+a.state.endDate.getDate(),e.next=5,N.a.post("/getDailyPaymentReport",{payments:a.state.payments,startDate:t,endDate:n,payTotal:a.state.payTotal.toFixed(2)}).then(function(){return N.a.get("/fetch-pdf",{responseType:"blob"})}).then(function(e){var t=new Blob([e.data],{type:"application/pdf"});Object(j.saveAs)(t,"DailyPayments.pdf")});case 5:a.setState({showAni:!1});case 6:case"end":return e.stop()}},e)})),a.onAfterDeleteDelivery=function(){var e=Object(o.a)(r.a.mark(function e(t){return r.a.wrap(function(e){for(;;)switch(e.prev=e.next){case 0:return e.next=2,N.a.post("/deletedelivery",{deliveryNoteNO:t}).then(function(e){e.data.status.localeCompare("Successfull")?R.a.fire("Failed !","","error"):(R.a.fire("Successful !","","success"),a.getDeliveries())});case 2:case"end":return e.stop()}},e)}));return function(t){return e.apply(this,arguments)}}(),a.onAfterDeletePayment=function(){var e=Object(o.a)(r.a.mark(function e(t){return r.a.wrap(function(e){for(;;)switch(e.prev=e.next){case 0:return e.next=2,N.a.post("/deletepayment",{payId:t}).then(function(e){e.data.status.localeCompare("Successfull")?R.a.fire("Failed !","","error"):(R.a.fire("Successful !","","success"),a.getPayments())});case 2:case"end":return e.stop()}},e)}));return function(t){return e.apply(this,arguments)}}(),a.selectRowProp={mode:"radio",bgColor:"yellow"},a.options={afterDeleteRow:a.onAfterDeleteDelivery},a.secondOptions={afterDeleteRow:a.onAfterDeletePayment},a.state={deliveries:[],payments:[],startDate:new Date,endDate:new Date,payTotal:0,showAni:!1},a.updateAcceptance=a.updateAcceptance.bind(Object(u.a)(a)),a}return Object(p.a)(t,e),Object(i.a)(t,[{key:"componentDidMount",value:function(){this.getDeliveries(),this.getPayments()}},{key:"updateAcceptance",value:function(e,t){var a=this;e.localeCompare("Pending..")?N.a.post("/updateacceptance",{deliveryAcceptance:"Pending..",deliveryNoteNO:t.deliveryNoteNO}).then(function(e){e.data.status.localeCompare("SuccessfullyAdded")?R.a.fire("Failed !","","error"):a.getDeliveries()}):N.a.post("/updateacceptance",{deliveryAcceptance:"Accepted",deliveryNoteNO:t.deliveryNoteNO}).then(function(e){e.data.status.localeCompare("SuccessfullyAdded")?(a.getDeliveries(),R.a.fire("Failed!","","error")):a.getDeliveries()})}},{key:"cellButton",value:function(e,t){var a=this;return e.localeCompare("Pending..")?e.localeCompare("Rejected")?f.a.createElement(h.a,{block:!0,color:"success","data-letter":t,onClick:function(){return a.updateAcceptance(e,t)},onDoubleClick:function(){a.onCellBButtonDouClick(e,t)}},e):f.a.createElement(h.a,{block:!0,color:"danger",onClick:function(){return a.updateAcceptance(e,t)},onDoubleClick:function(){a.onCellBButtonDouClick(e,t)}},e):f.a.createElement(h.a,{block:!0,color:"warning",onClick:function(){return a.updateAcceptance(e,t)},onDoubleClick:function(){a.onCellBButtonDouClick(e,t)}},e)}},{key:"dateFormater",value:function(e,t){var a=new Date(e),n=a.getFullYear()+"-"+(a.getMonth()+1)+"-"+a.getDate();return"".concat(n)}},{key:"priceFormat",value:function(e){return e.toFixed(2)}},{key:"render",value:function(){var e=this;return f.a.createElement("div",null,f.a.createElement(y.a,null,f.a.createElement(g.a,null,f.a.createElement(D.a,{xs:"14",sm:"12"},f.a.createElement(v.a,null,f.a.createElement(b.a,null,f.a.createElement("strong",null,"Delivery Details"),f.a.createElement(w.a,{row:!0},f.a.createElement(T.a,{utils:O.a},f.a.createElement(P.a,{container:!0,justify:"space-around"},f.a.createElement(D.a,null,f.a.createElement(k.a,{margin:"normal",id:"date-picker-dialog",label:"Start Date",format:"yyyy-MM-dd",value:this.state.startDate,onChange:this.handleStartDateChange,KeyboardButtonProps:{"aria-label":"change date"}})),f.a.createElement(D.a,{xs:"2",md:"3"},f.a.createElement(k.a,{margin:"normal",id:"date-picker-dialog",label:"End Date",format:"yyyy-MM-dd",value:this.state.endDate,onChange:this.handleEndDateChange,KeyboardButtonProps:{"aria-label":"change date"}})))))),f.a.createElement(E.a,{style:{backgroundColor:"#d9d9d9"}},f.a.createElement("div",null,f.a.createElement(A.BootstrapTable,{data:this.state.deliveries,pagination:!0,scrollTop:"Bottom",search:!0,exportCSV:!0,bodyStyle:{border:"green 1px solid"},containerStyle:{border:"#FFBB73 2.5px solid"},selectRow:this.selectRowProp,deleteRow:!0,options:this.options},f.a.createElement(A.TableHeaderColumn,{width:"80",tdStyle:{whiteSpace:"normal"},dataField:"deliveryNoteNO",isKey:!0},"Delivery ",f.a.createElement("br",null)," Note No"),f.a.createElement(A.TableHeaderColumn,{width:"100",tdStyle:{whiteSpace:"normal"},dataField:"vehicle_vehicleNumber"},"Lorry"),f.a.createElement(A.TableHeaderColumn,{width:"100",tdStyle:{whiteSpace:"normal"},dataField:"deliveryDistance"},"Distance",f.a.createElement("br",null),"(km)"),f.a.createElement(A.TableHeaderColumn,{width:"100",tdStyle:{whiteSpace:"normal"},dataField:"deliveryDate",dataFormat:this.dateFormater},"Delivery",f.a.createElement("br",null)," Date"),f.a.createElement(A.TableHeaderColumn,{width:"100",tdStyle:{whiteSpace:"normal"},dataField:"deliveryDepartureTime"},"Departure"),f.a.createElement(A.TableHeaderColumn,{width:"130",tdStyle:{whiteSpace:"normal"},dataField:"uploadingPlaceAddress"},"Unloading",f.a.createElement("br",null)," Place"),f.a.createElement(A.TableHeaderColumn,{width:"130",tdStyle:{whiteSpace:"normal"},dataField:"companyName"},"Comapany"),f.a.createElement(A.TableHeaderColumn,{width:"100",tdStyle:{whiteSpace:"normal"},dataField:"driverName"},"Driver"),f.a.createElement(A.TableHeaderColumn,{width:"200",tdStyle:{whiteSpace:"normal"},dataField:"deliveryAcceptance",dataFormat:this.cellButton.bind(this)},"Status")))),f.a.createElement(S.a,null,f.a.createElement(w.a,{row:!0},f.a.createElement(D.a,{md:"10"},f.a.createElement(F.a,null,"Total Deliveries : ",this.state.deliveries.length)),this.state.showAni?f.a.createElement("div",null,f.a.createElement("img",{src:x.a,alt:"loading..."})):null,f.a.createElement(D.a,null,f.a.createElement(h.a,{color:"info",onClick:function(){e.createAndDownloadDeliveryPdf()}},"Download"))))))),f.a.createElement(g.a,null,f.a.createElement(D.a,null,f.a.createElement(v.a,null,f.a.createElement(b.a,null,f.a.createElement("strong",null,"Payments")),f.a.createElement(E.a,{style:{backgroundColor:"#d9d9d9"}},f.a.createElement("div",null,f.a.createElement(A.BootstrapTable,{data:this.state.payments,pagination:!0,scrollTop:"Bottom",search:!0,bodyStyle:{border:"green 1px solid"},containerStyle:{border:"#FFBB73 2.5px solid"},exportCSV:!0,selectRow:this.selectRowProp,deleteRow:!0,options:this.secondOptions},f.a.createElement(A.TableHeaderColumn,{width:"100",tdStyle:{whiteSpace:"normal"},isKey:!0,dataField:"paymentsId"},"Pay No"),f.a.createElement(A.TableHeaderColumn,{width:"100",tdStyle:{whiteSpace:"normal"},dataField:"paymentsDate",dataFormat:this.dateFormater.bind(this)},"Date"),f.a.createElement(A.TableHeaderColumn,{width:"150",tdStyle:{whiteSpace:"normal"},dataField:"vehicle_vehicleNumber"},"Vehicle"),f.a.createElement(A.TableHeaderColumn,Object(n.a)({width:"150",tdStyle:{whiteSpace:"normal"},dataFormat:this.priceFormat.bind(this),dataField:"paymentsAmount"},"tdStyle",{textAlign:"right"}),"Amount"),f.a.createElement(A.TableHeaderColumn,{width:"130",tdStyle:{whiteSpace:"normal"},dataField:"paymentTypeType"},"Type"),f.a.createElement(A.TableHeaderColumn,{width:"200",tdStyle:{whiteSpace:"normal"},dataField:"paymentsDescription"},"Description")))),f.a.createElement(S.a,null,f.a.createElement(w.a,{row:!0},f.a.createElement(D.a,{md:"10"},f.a.createElement(F.a,null,"Total Payments : Rs ",this.state.payTotal.toFixed(2))),f.a.createElement(D.a,null,this.state.showAni?f.a.createElement("div",null,f.a.createElement("img",{src:x.a,alt:"loading..."})):null),f.a.createElement(D.a,null,f.a.createElement(h.a,{color:"info",onClick:function(){e.createAndDownloadPaymentPdf()}},"Download")))))))))}}]),t}(m.Component);t.default=U},898:function(e,t,a){"use strict";function n(){var e=this.constructor.getDerivedStateFromProps(this.props,this.state);null!==e&&void 0!==e&&this.setState(e)}function l(e){this.setState(function(t){var a=this.constructor.getDerivedStateFromProps(e,t);return null!==a&&void 0!==a?a:null}.bind(this))}function r(e,t){try{var a=this.props,n=this.state;this.props=e,this.state=t,this.__reactInternalSnapshotFlag=!0,this.__reactInternalSnapshot=this.getSnapshotBeforeUpdate(a,n)}finally{this.props=a,this.state=n}}function o(e){var t=e.prototype;if(!t||!t.isReactComponent)throw new Error("Can only polyfill class components");if("function"!==typeof e.getDerivedStateFromProps&&"function"!==typeof t.getSnapshotBeforeUpdate)return e;var a=null,o=null,c=null;if("function"===typeof t.componentWillMount?a="componentWillMount":"function"===typeof t.UNSAFE_componentWillMount&&(a="UNSAFE_componentWillMount"),"function"===typeof t.componentWillReceiveProps?o="componentWillReceiveProps":"function"===typeof t.UNSAFE_componentWillReceiveProps&&(o="UNSAFE_componentWillReceiveProps"),"function"===typeof t.componentWillUpdate?c="componentWillUpdate":"function"===typeof t.UNSAFE_componentWillUpdate&&(c="UNSAFE_componentWillUpdate"),null!==a||null!==o||null!==c){var i=e.displayName||e.name,s="function"===typeof e.getDerivedStateFromProps?"getDerivedStateFromProps()":"getSnapshotBeforeUpdate()";throw Error("Unsafe legacy lifecycles will not be called for components using new component APIs.\n\n"+i+" uses "+s+" but also contains the following legacy lifecycles:"+(null!==a?"\n  "+a:"")+(null!==o?"\n  "+o:"")+(null!==c?"\n  "+c:"")+"\n\nThe above lifecycles should be removed. Learn more about this warning here:\nhttps://fb.me/react-async-component-lifecycle-hooks")}if("function"===typeof e.getDerivedStateFromProps&&(t.componentWillMount=n,t.componentWillReceiveProps=l),"function"===typeof t.getSnapshotBeforeUpdate){if("function"!==typeof t.componentDidUpdate)throw new Error("Cannot polyfill getSnapshotBeforeUpdate() for components that do not define componentDidUpdate() on the prototype");t.componentWillUpdate=r;var d=t.componentDidUpdate;t.componentDidUpdate=function(e,t,a){var n=this.__reactInternalSnapshotFlag?this.__reactInternalSnapshot:a;d.call(this,e,t,n)}}return e}a.r(t),a.d(t,"polyfill",function(){return o}),n.__suppressDeprecationWarning=!0,l.__suppressDeprecationWarning=!0,r.__suppressDeprecationWarning=!0},946:function(e,t,a){"use strict";var n=a(35),l=a(100),r=a(3),o=a.n(r),c=a(112),i=a.n(c),s=a(886),d=a.n(s),u=a(887),p={tag:u.p,inverse:i.a.bool,color:i.a.string,body:i.a.bool,outline:i.a.bool,className:i.a.string,cssModule:i.a.object,innerRef:i.a.oneOfType([i.a.object,i.a.string,i.a.func])},m=function(e){var t=e.className,a=e.cssModule,r=e.color,c=e.body,i=e.inverse,s=e.outline,p=e.tag,m=e.innerRef,f=Object(l.a)(e,["className","cssModule","color","body","inverse","outline","tag","innerRef"]),h=Object(u.l)(d()(t,"card",!!i&&"text-white",!!c&&"card-body",!!r&&(s?"border":"bg")+"-"+r),a);return o.a.createElement(p,Object(n.a)({},f,{className:h,ref:m}))};m.propTypes=p,m.defaultProps={tag:"div"},t.a=m},947:function(e,t,a){"use strict";var n=a(35),l=a(100),r=a(3),o=a.n(r),c=a(112),i=a.n(c),s=a(886),d=a.n(s),u=a(887),p={tag:u.p,className:i.a.string,cssModule:i.a.object,innerRef:i.a.oneOfType([i.a.object,i.a.string,i.a.func])},m=function(e){var t=e.className,a=e.cssModule,r=e.innerRef,c=e.tag,i=Object(l.a)(e,["className","cssModule","innerRef","tag"]),s=Object(u.l)(d()(t,"card-body"),a);return o.a.createElement(c,Object(n.a)({},i,{className:s,ref:r}))};m.propTypes=p,m.defaultProps={tag:"div"},t.a=m},951:function(e,t,a){"use strict";var n=a(35),l=a(100),r=a(3),o=a.n(r),c=a(112),i=a.n(c),s=a(886),d=a.n(s),u=a(887),p={tag:u.p,className:i.a.string,cssModule:i.a.object},m=function(e){var t=e.className,a=e.cssModule,r=e.tag,c=Object(l.a)(e,["className","cssModule","tag"]),i=Object(u.l)(d()(t,"card-header"),a);return o.a.createElement(r,Object(n.a)({},c,{className:i}))};m.propTypes=p,m.defaultProps={tag:"div"},t.a=m}}]);
//# sourceMappingURL=54.8b8d7941.chunk.js.map
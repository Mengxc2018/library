<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>教师借阅历史记录管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
		
		// 编辑或者查看时页面图书类型赋值
		/* if($("#booktypeid")!=null){
			$("#booktype").val("${books.booktype}");
		} */
		
	
	function bookType(){
		top.layer.open({
		    type: 2,  
		    area: ['80%', '80%'],
		    title: '修改图书分类',
	        maxmin: true, //开启最大化最小化按钮
		    content: '${ctx}/booktype/bookType/bookTypeList?parent=0' ,
		    btn: ['确定', '关闭'],
		    yes: function(index, layero){
		    	 var body = top.layer.getChildFrame('body', index);
		         var iframeWin = layero.find('iframe')[0]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
		         var inputForm = body.find('#inputForm');
		         var rtn = iframeWin.contentWindow.doSubmit();
		         var arr = rtn.split("&");
		         var code = arr[0];
		         var id = arr[1];
		         var name = arr[2];
		         if("00"==code){
		        	 $("#booktypeid").val(id);
		        	 $("#booktype").val(name);
		        	 top.layer.close(index);
		         }
			  },
			  cancel: function(index){ 
		      }
		});
	}
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
		<h5>教师借阅历史记录列表 </h5>
		<div class="ibox-tools">
			<a class="collapse-link">
				<i class="fa fa-chevron-up"></i>
			</a>
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">
				<i class="fa fa-wrench"></i>
			</a>
			<ul class="dropdown-menu dropdown-user">
				<li><a href="#">选项1</a>
				</li>
				<li><a href="#">选项2</a>
				</li>
			</ul>
			<a class="close-link">
				<i class="fa fa-times"></i>
			</a>
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" modelAttribute="bookStudentHistory" action="${ctx}/bookteachershistory/bookteachershistory/" method="post" class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
		<div class="form-group">
			<div>
				<span>ISBN编号：</span>
					<form:input path="isbn" htmlEscape="false" maxlength="64" placeholder="请输入完整的ISBN号"  class=" form-control input-sm"/>
					&nbsp;&nbsp;
				<span>索书号：</span>
					<form:input path="ssh" htmlEscape="false" maxlength="64"  class=" form-control input-sm"/>
					&nbsp;&nbsp;
				<span>图书分类：</span>
					<form:input path="booktype" htmlEscape="false" maxlength="64"  class=" form-control input-sm"  onclick="bookType()"  onfocus="this.blur()"/>
					&nbsp;&nbsp;
				<span>书名：</span>
					<form:input path="name" htmlEscape="false" maxlength="500"  class=" form-control input-sm"/>
					&nbsp;&nbsp;
			</div>
			<div style="padding-top:3px">
				<span> 作 者：</span>
					<form:input path="author" htmlEscape="false" maxlength="100"  class=" form-control input-sm"/>
					&nbsp;&nbsp;
				<span>出版社：</span>
			
				<span>借出时间：</span>
					<form:input path="jcsj" htmlEscape="false"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  onfocus="this.blur()"  class="form-control " />
					&nbsp;&nbsp;
				<%-- <span>应还日期：</span>
					<form:input path="yhrq" htmlEscape="false"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  onfocus="this.blur()"  class="form-control " />
					&nbsp;&nbsp; --%>
				<span>归还时间：</span>
					<form:input path="ghsj" htmlEscape="false"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  onfocus="this.blur()"  class="form-control " />
			</div>
			<div style="padding-top:3px">
				<span>教师姓名：</span>
					<form:input path="teachersName" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
					&nbsp;&nbsp;
				<span>教师工号：</span>
					<form:input path="teachersBh" htmlEscape="false" maxlength="255"  class=" form-control input-sm"/>
					&nbsp;&nbsp;
			</div>
		 </div>	
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="bookteachershistory:bookteachershistory:add">
				<table:addRow url="${ctx}/bookteachershistory/bookteachershistory/form" title="教师借阅历史记录" width="85%" height="85%"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="bookteachershistory:bookteachershistory:edit">
			    <table:editRow url="${ctx}/bookteachershistory/bookteachershistory/form" title="教师借阅历史记录" id="contentTable" width="85%" height="85%"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="bookteachershistory:bookteachershistory:del">
				<table:delRow url="${ctx}/bookteachershistory/bookteachershistory/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="bookteachershistory:bookteachershistory:import">
				<table:importExcel url="${ctx}/bookteachershistory/bookteachershistory/import"></table:importExcel><!-- 导入按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="bookteachershistory:bookteachershistory:export">
	       		<table:exportExcel url="${ctx}/bookteachershistory/bookteachershistory/export"></table:exportExcel><!-- 导出按钮 -->
	       	</shiro:hasPermission>
	       <button class="btn btn-primary btn-outline btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		
			</div>
		<div class="pull-right">
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
		</div>
	</div>
	</div>
	
	<!-- 表格 -->
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th> <input type="checkbox" class="i-checks"></th>
				<th  class="sort-column isbn">ISBN编号</th>
				<th  class="sort-column ssh">索书号</th>
				<th  class="sort-column booktype">图书分类</th>
				<th  class="sort-column name">书名</th>
				<th  class="sort-column author">作者</th>
				<th  class="sort-column cbs">出版社</th>
				<th  class="sort-column price">价格</th>
				<th  class="sort-column teachersName">教师</th>
				<th  class="sort-column teachersBh">教师工号</th>
				<th  class="sort-column jcsj">借出时间</th>
				<th  class="sort-column yhrq">应还日期</th>
				<th  class="sort-column ghsj">归还时间</th>
				<th  class="sort-column cqts">超期天数</th>
				<th  class="sort-column pcsj">赔偿时间</th>
				<th  class="sort-column pcje">赔偿金额</th>
				<th  class="sort-column remarks">备注</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bookStudentHistory">
			<tr>
				<td> <input type="checkbox" id="${bookStudentHistory.id}" class="i-checks"></td>
				<td><a  href="#" onclick="openDialogView('查看教师借阅历史记录', '${ctx}/bookteachershistory/bookteachershistory/form?id=${bookStudentHistory.id}','85%', '85%')">
					${bookStudentHistory.isbn}
				</a></td>
				<td>
					${bookStudentHistory.ssh}
				</td>
				<td>
					${bookStudentHistory.booktype}
				</td>
				<td>
					${bookStudentHistory.name}
				</td>
				<td>
					${bookStudentHistory.author}
				</td>
				<td>
					${bookStudentHistory.cbs}
				</td>
				<td>
					${bookStudentHistory.price}
				</td>
				<td>
					${bookStudentHistory.teachersName}
				</td>
				<td>
					${bookStudentHistory.teachersBh}
				</td>
				<td>
					${bookStudentHistory.jcsj}
				</td>
				<td>
					${bookStudentHistory.yhrq}
				</td>
				<td>
					${bookStudentHistory.ghsj}
				</td>
				<td>
					${bookStudentHistory.cqts}
				</td>
				<td>
					${bookStudentHistory.pcsj}
				</td>
				<td>
					${bookStudentHistory.pcje}
				</td>
				<td>
					${bookStudentHistory.remarks}
				</td>
				<td>
					<shiro:hasPermission name="bookstudenthistory:bookStudentHistory:view">
						<a href="#" onclick="openDialogView('查看教师借阅历史记录', '${ctx}/bookstudenthistory/bookStudentHistory/form?id=${bookStudentHistory.id}','85%', '85%')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i> 查看</a>
					</shiro:hasPermission>
					<shiro:hasPermission name="bookstudenthistory:bookStudentHistory:edit">
    					<a href="#" onclick="openDialog('修改教师借阅历史记录', '${ctx}/bookstudenthistory/bookStudentHistory/form?id=${bookStudentHistory.id}','85%', '85%')" class="btn btn-success btn-xs" ><i class="fa fa-edit"></i> 修改</a>
    				</shiro:hasPermission>
    				<shiro:hasPermission name="bookstudenthistory:bookStudentHistory:del">
						<a href="${ctx}/bookstudenthistory/bookStudentHistory/delete?id=${bookStudentHistory.id}" onclick="return confirmx('确认要删除该教师借阅历史记录吗？', this.href)"   class="btn btn-danger btn-xs"><i class="fa fa-trash"></i> 删除</a>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
		<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
	<br/>
	<br/>
	</div>
	</div>
</div>
</body>
</html>
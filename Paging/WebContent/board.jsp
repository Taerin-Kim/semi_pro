<%@page import="com.util.Paging"%>
<%@page import="com.util.BoardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	List<BoardDto> list = (List<BoardDto>)request.getAttribute("list");

	int pageNum = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
	
	int totalCount = Integer.parseInt(request.getAttribute("totalCount") + "");
	
	
	Paging paging = new Paging();
	paging.setPageNo(pageNum);
	paging.setPageSize(10);
	paging.setTotalCount(totalCount);

	BoardDto dao = new BoardDto();
%>

<div class="paging">
			<div class="div-paging">
				<input type="button" onclick="pageMove(<%=paging.getFirstPageNo()%>)" value="<<" style="color: grey;">
				<input type="button" onclick="pageMove(<%=paging.getPrevPageNo()%>)" value="<" style="color: grey;">

<%
				for (int i = paging.getStartPageNo(); i <= paging.getEndPageNo(); i++) {
%>
				<a onclick="pageMove(<%=i%>)"><%=i%></a>
<%
				}
%>
	
				<input type="button" onclick="pageMove(<%=paging.getNextPageNo()%>)" value=">" style="color: grey;">
				<input type="button" onclick="pageMove(<%=paging.getFinalPageNo()%>)" value=">>" style="color: grey;">
				<script>
					function pageMove(page){
						location.href='paging.do?page='+page;
					}
				</script>
			</div>
		</div>


</body>
</html>
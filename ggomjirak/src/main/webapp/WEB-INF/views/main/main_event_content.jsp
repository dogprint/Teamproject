<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>
<!-- 이벤트 -->
<div class="row m_top">
	<div class="col-md-12">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
			
				<table class="table table-borderless">
				  <thead>
				    <tr>
				      <th scope="col" colspan="2"><h3>${eventVo.e_title}</h3></th>
				      
				    </tr>
				  </thead>
				  <tbody>
				    <tr>
				      <th scope="row">이벤트 진행 기간 : ${eventVo.start_date} ~ ${eventVo.end_date}</th>
				      <td class="text-right">작성일 : ${eventVo.reg_date}</td>
				    </tr>
				    <tr>
				      <td colspan="2">
				      <c:if test="${eventVo.e_img != null}">
				      	<img src="/eventImg/displayImage?filePath=${eventVo.e_img}"
				      		class="rounded mx-auto d-block" alt="EventImage"
							width="1200px" height="600px">
				      </c:if>
				      </td>
				    </tr>
				    <tr>
				    	<td colspan="2">
				    		${eventVo.e_content}
				    	</td>
				    </tr>
				  </tbody>
				</table>
				<div class="row justify-content-center">
					<a href="/main/mainEvent" type="button" class="site-btn center">목록</a>
				</div>			
			</div>
			
			<div class="col-md-2"></div>
		</div>
	</div>
</div>

<!-- 이벤트 끝 -->

<%@ include file="../include/footer.jsp" %>
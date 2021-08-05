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
			
				<div class="container">
	
					<ul class="nav nav-tabs">
						
						<li class="nav-item"><a id="list" class="nav-link" href="/main/mainEvent">진행중인 이벤트</a></li>
						<li class="nav-item"><a id="listEnd" class="nav-link" href="/main/mainEventListEnd">종료된 이벤트</a></li>
						<li class="nav-item"><a id="listAll" class="nav-link active" href="/main/mainEventListAll">전체 이벤트</a></li>
					</ul>
				</div>
				
				<div style="padding: 20px; overflow: hidden;">
				
				<c:forEach var="event" items="${eventListAll}">
				<div class="col-lg-6 col-md-12 col-sm-12" style="float:left; padding: 30px">
					<div class="featured__item">
						<div>
							<a href="/main/mainEventContent?e_no=${event.e_no}">
								<img 
									<c:choose>
										<c:when test="${event.e_img != null}">
											src="/eventImg/displayImage?filePath=${event.e_img}" 
											alt="Event Image"
										</c:when>
										<c:otherwise>
											src="../resources/img/eximage.png" 
											alt="None Image"
										</c:otherwise>
									</c:choose>
								class="rounded mx-auto d-block"
								width="700px" height="300px">
							</a>
						</div>
						<div class="featured__item__text">
							<h6><a href="/main/mainEventContent?e_no=${event.e_no}">${event.e_title}</a></h6>
							<h5>${event.start_date} ~ ${event.end_date}</h5>
						</div>
					</div>
				</div>
				</c:forEach>
				
				
				</div>
				
				<div class="product__pagination justify-content-center " style="display: flex">
				<c:if test="${pagingDto.startPage != 1}">
                        <a href="/main/mainEventListAll?page=${pagingDto.startPage - 1}&perPage=${pagingDto.perPage}"><i class="fa fa-long-arrow-left"></i></a>
                </c:if>
                <c:forEach var="v" begin="${pagingDto.startPage}" end="${pagingDto.endPage}">
                	<a
                		<c:choose>
							<c:when test="${v == pagingDto.page}">
								class="green_background" style="color: white;"
						 	</c:when>
						 	<c:otherwise>
						 		class="page-item"
							</c:otherwise>
						</c:choose>
                        href="/main/mainEventListAll?page=${v}&perPage=${pagingDto.perPage}">${v}</a>
                </c:forEach>
                <c:if test="${pagingDto.endPage < pagingDto.totalPage}">
                        <a href="/main/mainEventListAll?page=${pagingDto.endPage + 1}&perPage=${pagingDto.perPage}"><i class="fa fa-long-arrow-right green_background"></i></a>
                </c:if>
                </div>
								
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
</div>

<!-- 이벤트 끝 -->

<%@ include file="../include/footer.jsp" %>
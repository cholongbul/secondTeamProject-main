<%@ page  contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
		request.setCharacterEncoding("EUC-KR");
		
%>
<%@include file= "../bar/bar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:if test="${sessionScope.userID != null}">
	<c:set var="messageType" value="오류 메시지" scope="session"/>
	<c:set var="messageContent" value="현재 로그인이 되어 있는 상태입니다." scope="session"/>
</c:if>
<script type="text/javascript">
</script>
<title>Insert title here</title>
</head>
<body>
	<!-- 로그인 폼 -->
		<div class="container" style="padding-top: 50px;">
			<form method="post" action="../user/UserLogin">
				<table class="table table-bordered table-hovber" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"><h4>로그인</h4></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 110px"><h5>아이디</h5></td>
							<td><input class="form-control" type="text" name="userID" maxlength="20" placeholder="아이디를 입력하세요"></td>
						</tr>
						<tr>
							<td style="width: 110px"><h5>비밀번호</h5></td>
							<td><input class="form-control" type="password" name="userPassword" maxlength="20" placeholder="비밀번호를 입력하세요"></td>
						</tr>
						<tr>
							<td style="text-align: left;" colspan="2"><input class="btn btn-primary pull-right" type="submit" value="로그인"></td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	<c:set var="messageType" value="null"> </c:set>
			<c:if test="${sessionScope.messageType != null}">
				<c:set var="messageType" value="${sessionScope.messageType}"></c:set>
			<c:if test="${messageType eq  '오류메세지'}">  
				<c:set var="m" value="panel-success"></c:set>
			</c:if>
				<c:set var="m" value="panel-warning"></c:set>
		</c:if>
	
		<c:set var="messageContent" value="null"> </c:set>
		<c:if test="${sessionScope.messageContent != null}">
			<c:set var="messageContent" value="${sessionScope.messageContent}"></c:set>
		</c:if>
		<!-- 모달창 만들기 -->
		<c:if test="${not empty sessionScope.messageContent}" >
			<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
				<div class="vertical-alignment-helper">
					<div class="modal-dialog vertical-align-center">
							<div class="modal-content  ${m}" >
								<div class="modal-header panel-heading">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">&times</span>
										<span class="sr-only">Close</span>
									</button>
									<h4 class="modal-title">
										${messageType}
									</h4>
								</div>
								<div class="modal-body">
									${messageContent}
								</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="location.href='../login/login.jsp';">
								 	확인
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 모달창 실행 -->
				<script type="text/javascript">
					$('#messageModal').modal("show");
				</script>
			<!--서버로부터 받아온 세션인 //사용한 세션 제거 -->
				<c:remove var="messageContent" scope="session" />
				<c:remove var="messageType" scope="session" />
		</c:if>
		<!-- 체크 모달-->
		<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="vertical-alignment-helper">
					<div class="modal-dialog vertical-align-center">
							<div id="checkType" class="modal-content panel-info">
								<div class="modal-header panel-heading">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">&times</span>
										<span class="sr-only">Close</span>
									</button>
									<h4 class="modal-title">
										아이디 중복 확인 메세지
									</h4>
								</div>
								<div id="checkMessage" class="modal-body">
								</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary"  data-dismiss="modal" >
								 	확인
								</button>
							</div>
						</div>
					</div>
				</div>
		</div>
<%@include file="../bar/bottom.jsp" %>		
</body>
</html>
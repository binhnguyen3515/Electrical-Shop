<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>

    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" integrity="sha512-YWzhKL2whUzgiheMoBFwW8CKV4qpHQAEuvilg9FAn5VJUDwKZZxkJNuGM4XkWuk94WCrrwslk8yWNGmY1EduTA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/flag.min.css">

    <base href="${pageContext.servletContext.contextPath}"/>
    <title>PS14048 - ASM - JAVA5</title>
    
</head>

<body class="indexContent">
    
    <!-- Top Bar-->
    <div class="topbar row">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark p-0">
            <div class="container-fluid">
              <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                  <li class="nav-item">
                    <a class="nav-link ps-0" aria-current="page" href="#">HN: +084 913 806 577</a>
                  </li>
                  <li class="nav-item">
                    <span class="nav-link">|</span>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="#">HCM: +84 091 386 755</a>
                  </li>
                </ul>
                <form class="d-flex">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a href="#" class="nav-link d-flex align-items-center px-0"><i class="icon-facebook d-flex align-items-center"></i></a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link d-flex align-items-center px-0"><i class="icon-twitter d-flex align-items-center"></i></a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link d-flex align-items-center px-0"><i class="icon-instagram d-flex align-items-center"></i></a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link d-flex align-items-center px-0"><i class="icon-skype d-flex align-items-center"></i></a>
                        </li>
                    </ul>
                </form>
              </div>
            </div>
        </nav>
    </div>
    <!-- Top Bar Edge-->
    <!-- Logo Bar-->
    <div class="logo-bar row">
        <nav class="navbar navbar-expand-lg navbar-light py-3">
            <div class="container-fluid px-3">
              <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                  <li class="nav-item">
                    <form method="get" action="${pageContext.servletContext.contextPath}" class="d-flex">
                        <input name="keywords" value="${keywords}" class="form-control rounded-0" id="searchBox" type="search" placeholder="Search" aria-label="Search">
                        <button class="btn mainColor rounded-0" type="submit" style="background-image: url('${pageContext.request.contextPath}/assets/img/icons8_search_15px.png'); background-repeat: no-repeat; background-position: center center; width: 38px; height: 38px;"></button>
                    </form>
                  </li>
                </ul>
                <img class="icon-brand" src="${pageContext.servletContext.contextPath}/assets/img/logo6fixed.png" style="height:50px ;"/> 
                <form class="d-flex align-items-center">
                    <a href="${pageContext.request.contextPath}/detail/Cart/CartInfo" class="cart-icon me-3"><i class="fa fa-shopping-cart position-relative" style="font-size: 1.5rem">
                    	<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger fw-bold" id="cartQuantity" style="font-size: 12px">
						    <c:if test="${sessionScope['scopedTarget.cart'] != null}">
						    	${sessionScope['scopedTarget.cart'].count}
						    </c:if>
						    <c:if test="${sessionScope['scopedTarget.cart'] == null}">
						    	0
						    </c:if>
						    <span class="visually-hidden">unread messages</span>
						  </span>
                    </i></a>
                    <a class="language" href="${pageContext.servletContext.contextPath}/?lang=vi"><i class="vietnam flag"></i></a>
                    <a class="language" href="${pageContext.servletContext.contextPath}/?lang=en"><i class="united states flag"></i></a>
                </form>
              </div>
            </div>
        </nav>
    </div>
    <!-- Logo Bar Edge-->
    <!-- Menu Bar-->
    <div class="menuBar row text-white" id="menuBarColor">
        <div class="container d-flex align-items-center">
            <nav class="navbar navbar-expand-lg mx-auto navbar-dark " >
                <div class="container-fluid">
                    <div class="navbar-collapse collapse " id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#"><s:message code="menu.home"/></a>
                        </li>
                        <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#"><s:message code="menu.about"/></a>
                        </li>
                        <li class="nav-item dropdown">
                            <div class="dropdown">
                                <a class="dropdown-toggle nav-link active" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                                    <s:message code="menu.categories"/>
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                    <c:forEach var="item" items="${cateGoryList}">
                                        <li><a class="dropdown-item dropdownCategory" data-cateID="${item.categoryID}" style="cursor: pointer;">${item.name}</a></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item dropdown">
                            <div class="dropdown">
                                <a class="dropdown-toggle nav-link active" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                                    <s:message code="menu.account"/>
                                </a>
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                	<c:if test="${empty sessionScope.loginInfo }">
                                		<li><a class="dropdown-item" href="${pageContext.servletContext.contextPath}/login"><s:message code="menu.login"/></a></li>
                                        <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#forgotPassModal" style="cursor: pointer;"><s:message code="menu.forgotPass"/></a></li>
                                	</c:if>
                                    <li><a class="dropdown-item" href="${pageContext.servletContext.contextPath}/sign-up"><s:message code="menu.signup"/></a></li>
                                    <c:if test="${not empty sessionScope.loginInfo }">
                                		<li><a class="dropdown-item" href="" data-bs-toggle="modal" data-bs-target="#profileModal"><s:message code="menu.profile"/></a></li>
                                		<li><a class="dropdown-item" href="${pageContext.servletContext.contextPath}/logout"><s:message code="menu.logout"/></a></li>
                                		<li><a class="dropdown-item" id="checkYourOrder" style="cursor: pointer;"><s:message code="menu.orders"/></a></li>
                                        <li><a class="dropdown-item" id="myFavoriteList" style="cursor: pointer;"><s:message code="menu.favoriteList"/></a></li>
                                	</c:if>
                                	<c:if test="${not empty sessionScope.loginInfo && (sessionScope.loginInfo.role == 'Admin' || sessionScope.loginInfo.role == 'Staff')}">
                                		<li><a class="dropdown-item" href="${pageContext.servletContext.contextPath}/admin"><s:message code="menu.admin"/></a></li>
                                	</c:if>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    </div>
                </div>
            </nav>
        </div>
        
    </div>
    <!-- Menu Bar Edge-->
    <!-- Container-->
    <div class="containerSection row p-3">
        <!--Side bar-->
        <div class="col-md-2">
        	<%@include file="/views/sharedSideBar_index_detail.jsp" %>
        </div>
        <!--Side bar edge-->
        <!--Main content-->
        <div class="col-md-10">
            <!--Carousel section-->
            <div id="carouselExampleIndicators" class="carousel slide <c:if test="${sessionScope.closeBanner == true }">d-none</c:if> mb-3" data-bs-ride="carousel">
                <div class="carousel-indicators">
                  <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                  <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                  <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                  <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
                  <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="4" aria-label="Slide 5"></button>
                </div>
                <div class="carousel-inner">
                  <div class="carousel-item active">
                    <img src="${pageContext.request.contextPath}/assets/img/poster9.jpg" class="d-block w-100" alt="...">
                  </div>
                  <div class="carousel-item">
                    <img src="${pageContext.servletContext.contextPath}/assets/img/posterfixed1.png" class="d-block w-100" alt="...">
                  </div>
                  <div class="carousel-item">
                    <img src="${pageContext.servletContext.contextPath}/assets/img/posterfixed2.png" class="d-block w-100" alt="...">
                  </div>
                  <div class="carousel-item">
                    <img src="${pageContext.servletContext.contextPath}/assets/img/posterfixed3.png" class="d-block w-100" alt="...">
                  </div>
                  <div class="carousel-item">
                    <img src="${pageContext.servletContext.contextPath}/assets/img/posterfixed4.png" class="d-block w-100" alt="...">
                  </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                  <span class="visually-hidden">Next</span>
                </button>
              </div>
              <!--Carousel section edge-->
              <!--Sort section-->
              <div class="row">
                <div class="col-md-2"></div>
                <c:if test="${sessionScope.closeBanner == false || sessionScope.closeBanner == null}">
                	<div class="col-md-2 text-end"><a class="btn btn-danger"  href="${pageContext.request.contextPath}/?closeBanner=true"><i class="fas fa-times-circle"></i></a></div>
                </c:if>
                <c:if test="${sessionScope.closeBanner == true}">
                	<div class="col-md-2 text-end"><a class="btn mainColor text-white"  href="${pageContext.request.contextPath}/?closeBanner=false"><i class="fas fa-chevron-circle-down"></i></a></div>
                </c:if>
               
                <div class="col-md-4">
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="inputGroupSelect01">Sort By</label>
                        <select class="form-select" id="inputGroupSelect01" >
                          <option selected hidden="" value="all">Choose...</option>
                          <c:forEach var="item" items="${cateGoryList}">
                          	<option value="${item.categoryID}" <c:if test="${sortMessage == item.categoryID}">selected</c:if>>${item.name}</option>
                          </c:forEach>
                          	<option value="all" <c:if test="${sortMessage == 'all'}">selected</c:if>>All</option>
                        </select>
                      </div>                             
                </div>
                <div class="col-md-4">
                    <div class="input-group mb-3">
                        <label class="input-group-text" for="inputGroupSelect02">Shows</label>
                        <select class="form-select" id="inputGroupSelect02">
                          <option selected hidden="" value="10">Choose...</option>
                          <option value="4" <c:if test="${showMessage == 4}">selected</c:if>>4</option>
                          <option value="8" <c:if test="${showMessage == 8}">selected</c:if>>8</option>
                          <option value="12" <c:if test="${showMessage == 12}">selected</c:if>>12</option>
                          <option value="16" <c:if test="${showMessage == 16}">selected</c:if>>16</option>
                          <option value="10000" <c:if test="${showMessage == 10000}">selected</c:if>>All</option>
                        </select>
                      </div>                          
                </div>
            </div>  
            <!--Sort section edge-->     
            <!-- Product list section-->  
            <div class="productList" id="productList">
                <c:forEach var="item" items="${productList.content}" varStatus="loop">
                    <div class="mb-3" id="productContainer">
                        <div class="border border-light col" style="box-shadow: 0px 2px 15px rgb(0 0 0/ 10%);" id="productContainer1">
                            <div class="d-flex" id="innerContent1">
                                <div class="text-white m-1 d-flex">
                                	<c:if test="${item.discount != 0}">
                                		<div class="bg-danger p-1">SALE</div> <div class="bg-success ms-1 p-1">${item.discount} %</div>
                                	</c:if>
                                </div>
                                <span class="text-white bg-primary p-1 ms-auto m-1">HOT</span> 
                            </div>
	                        <div class="row mx-auto mb-3 text-center" id="innerContent2"> 
	                            <a href="${pageContext.servletContext.contextPath}/detail/${item.productID}"><img src="${pageContext.servletContext.contextPath}/home/ProductImages/${item.category.name}/${item.picture}" alt="" style="width:222.98px;height:250px"/></a>
	                        </div>
	                        <div class="row text-center pt-1 pb-1 justify-content-center product-name-price mx-0" id="priceContent" style = "background-color: #e3dfda;">
	                            <div class="row w-100 justify-content-center" id="priceContent1"><h6>${item.name}</h6></div>
	                            <div class="row w-100 justify-content-center" id="priceContent2">
		                            <span class="text-danger">
		                            	<b><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${item.detailedProducts[0].price * (1-item.discount/100)}"/></b>
		                            </span>
	                                <div class="originalPrice">
	                                	<small style="text-decoration:line-through;line-height: 24px;">
		                                	<c:if test="${item.discount != 0}">
		                                		<fmt:formatNumber type="number" maxFractionDigits ="3" value ="${item.detailedProducts[0].price}"/>
		                                	</c:if>
	                                	</small>
	                                </div>
	                            </div>
	                        </div>
                        </div>
                    </div>
                </c:forEach>
            </div>  
            <%-- <h3>${fn:substringAfter(requestScope['javax.servlet.forward.query_string'],"page=")}</h3> --%>
            <!-- Product list section Edge-->    
            <!-- Pagination-->
			<nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
                  <li class="page-item <c:if test="${productList.number == 0}"> disabled</c:if>">
                    <a class="page-link" href="${pageContext.servletContext.contextPath}/?sortByA_Z=${sortByA_Z}&sortBy=${sortMessage}&showByNumber=${showMessage}&keywords=${keywords}&min=${min}&max=${max}&page=${productList.number-1}" aria-label="Previous">
                      <span aria-hidden="true">&laquo;</span>
                    </a>
                  </li>
                  
                  <c:forEach var="page" begin="0" end="${productList.totalPages-1}">
                  		<li class="page-item <c:if test="${fn:substringAfter(requestScope['javax.servlet.forward.query_string'],'page=') == page}">active</c:if>"><a class="page-link" href="${pageContext.servletContext.contextPath}/?sortByA_Z=${sortByA_Z}&sortBy=${sortMessage}&showByNumber=${showMessage}&keywords=${keywords}&min=${min}&max=${max}&page=${page}">${page+1}</a></li>
                  </c:forEach>
                  <li class="page-item <c:if test="${productList.number == productList.totalPages-1}"> disabled</c:if>">
                    <a class="page-link" href="${pageContext.servletContext.contextPath}/?sortByA_Z=${sortByA_Z}&sortBy=${sortMessage}&showByNumber=${showMessage}&keywords=${keywords}&min=${min}&max=${max}&page=${productList.number+1}" aria-label="Next">
                      <span aria-hidden="true">&raquo;</span>
                    </a>
                  </li>
                </ul>
              </nav>
            <!-- Pagination Edge-->
        </div>
    <!--Main content Edge-->
    </div>
    <!-- Container edge-->
    <!-- Footer-->
    <div class="footer">
        <div class="row text-center text-lg-start bg-light text-muted">
            <div class="col" style="background-color: #4a4346; color: white; margin-top: 0px; padding-top: 0px;">
                <div class="container1 text-center text-md-start">
                    <!-- Grid row -->
                    <div class="row mt-3" id="detailSize">
                        <!-- Grid column -->
                        <div class="col-md-3 col-lg-4 col-xl-3 mx-auto mb-4">
                            <!-- Content -->
                            <h6 class="text-uppercase fw-bold mb-4 text-center"><i class="fas fa-gem me-3"></i>Electrical shop</h6>
                            <p class="text-center">This is my website created for Java 5 Assignment. The template is based on bootstrap 5.&nbsp;</p>
                        </div>
                        <!-- Grid column -->
                        <!-- Grid column -->
                        <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-4 text-center">
                            <!-- Links -->
                            <h6 class="text-uppercase fw-bold mb-4 "> Products </h6>
                            <p> <a href="#!" class="text-white">Laptop</a> </p>
                            <p> <a href="#!" class="text-white">Headset</a> </p>
                            <p> <a href="#!" class="text-white">Iphone</a> </p>
                            <p> <a href="#!" class="text-white">Monitor</a> </p>
                        </div>
                        <!-- Grid column -->
                        <!-- Grid column -->
                        <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mb-4 text-center">
                            <!-- Links -->
                            <h6 class="text-uppercase fw-bold mb-4"> Useful links </h6>
                            <p> <a href="#!" class="text-white">Pricing</a> </p>
                            <p> <a href="#!" class="text-white">Settings</a> </p>
                            <p> <a href="#!" class="text-white">Orders</a> </p>
                            <p> <a href="#!" class="text-white">Help</a> </p>
                        </div>
                        <!-- Grid column -->
                        <!-- Grid column -->
                        <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mb-md-0 mb-4 text-center">
                            <!-- Links -->
                            <h6 class="text-uppercase fw-bold mb-4"> Contact </h6>
                            <p><i class="fas fa-home me-3"></i> FPT PolyTechnic</p>
                            <p><i class="fas fa-envelope me-3"></i> binhntps14048@fpt.edu.vn</p>
                            <p><i class="fas fa-phone me-3"></i> + 84 913 806 777</p>
                            <p><i class="fas fa-print me-3"></i> + 84 913 806 772</p>
                        </div>
                        <!-- Grid column -->
                    </div>
                    <!-- Grid row -->
                </div>
            </div>
            <!-- Section: Links  -->
    
        </div>
        <div class="row p-4 text-center" style="background-color:#332e30;color:white">
                <span>© 2021 Copyright: PS14048 - Nguyễn Thái Bình</span>
        </div>
    </div>
    <!-- Footer Edge-->
    <!-- Profile Include Session -->
    <div class="profileInclude">
        <%@include file="/views/profileModal/profileModal.jsp" %>
    </div>
    <!-- Profile Include Session Edge-->

</body>

<script>
   $(document).ready(function(e){
       $("a[href*=closeBanner]").on('click',function(){
           var param = $(this).attr('href');
           $.ajax({
        	   type:"get",
               url: "${pageContext.request.contextPath}/closeBanner"+param,
               success: function(){
                   location.reload();
               }
           });
           e.preventDefault();
       })
       $('#inputGroupSelect01').on('change',function(){
       		var getID = $(this).val();
            var getNum = $('#inputGroupSelect02').val();
            window.location = "${pageContext.request.contextPath}/?sortByA_Z=A_Z&sortBy="+getID+"&showByNumber="+getNum+"&min="+"123696978966989"+"&max="+"123696978966989";
   		})
   	   $('#inputGroupSelect02').on('change',function(){
            var getID = $('#inputGroupSelect01').val();
       		var getNum = $(this).val();
            var keywords = $('#searchBox').val();
            window.location = "${pageContext.request.contextPath}/?sortByA_Z=${sortByA_Z}&sortBy="+getID+"&showByNumber="+getNum+"&keywords="+keywords+"&min="+"${min}"+"&max="+"${max}";
   	    })
        $('#checkYourOrder').click(function(){
            console.log("log running");
            window.location = "${pageContext.servletContext.contextPath}/detail/Cart/Log";
        })
        $('#myFavoriteList').click(function() {
            console.log("fav running");
            window.location = "${pageContext.servletContext.contextPath}/detail/Cart/FavoriteList";
        })
        $(".language").on("click", function() {
			var param = $(this).prop("href");
			console.log(param);
			$.ajax({
				url : "${pageContext.servletContext.contextPath}/" + param,
				success : function() {
					location.reload();
				}
			});
		})
   })
</script>
<c:if test="${sessionScope.message != null}">
    <jsp:include page="/views/messageModal/messageModal.jsp"></jsp:include>
    <script>
        $(document).ready(function(){
            $('#myModal').modal('show'); 

            $('#close1 ,#close2').click(function() {
                <% session.removeAttribute("message");%>
            })  
        })
    </script> 
</c:if>
<c:if test="${sessionScope.logStatus != null}">
    <script>
        $(document).ready(function(){
            $('#yourOrders').modal('show');

            $('#closeConfirmed3 ,#closeConfirmed4').click(function() {
                <% session.removeAttribute("logStatus");%>
            })  
        })
    </script> 
</c:if>
<c:if test="${sessionScope.favoriteListLog != null}">
    <script>
        $(document).ready(function(){
            $('#yourFavoriteList').modal('show');

            $('#closeConfirmed5 ,#closeConfirmed6').click(function() {
                <% session.removeAttribute("favoriteListLog");%>
            })  
        })
    </script> 
</c:if>
</html>
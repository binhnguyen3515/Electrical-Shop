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
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/detail.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" integrity="sha512-YWzhKL2whUzgiheMoBFwW8CKV4qpHQAEuvilg9FAn5VJUDwKZZxkJNuGM4XkWuk94WCrrwslk8yWNGmY1EduTA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/assets/css/flag.min.css">

    <base href="${pageContext.servletContext.contextPath}"/>
    <title>PS14048 - ASM - JAVA5</title>
</head>
<body>
    <!-- Top Bar-->
    <div class="topbar row">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark p-0" >
            <div class="container-fluid" id="detailSize">
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
            <div class="container-fluid" id="detailSize">
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
						    	<c:out value="${sessionScope['scopedTarget.cart'].count}"/>
						    </c:if>
						    <c:if test="${sessionScope['scopedTarget.cart'] == null}">
						    	0
						    </c:if>
						    <span class="visually-hidden">unread messages</span>
						  </span>
                    </i></a>
                    <a class="language" href="${pageContext.servletContext.contextPath}/detail/${listDetailProduct[0].product.productID}?lang=vi"><i class="vietnam flag"></i></a>
                    <a class="language" href="${pageContext.servletContext.contextPath}/detail/${listDetailProduct[0].product.productID}?lang=en"><i class="united states flag"></i></a>
                </form>
              </div>
            </div>
        </nav>
    </div>
    <!-- Logo Bar Edge-->
    <!-- Menu Bar-->
    <div class="menuBar row text-white" id="menuBarColor">
        <div class="container d-flex align-items-center ">
            <nav class="navbar navbar-expand-lg mx-auto navbar-dark">
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
    <div class="containerSection row p-3" id="detailSize">
        <!--Side bar-->
        <div class="col-md-3">
            <!--Hidden Content For show By number-->
            <select class="form-select" id="inputGroupSelect02">
                <option selected hidden="" value="10">Choose...</option>
                <option value="4" <c:if test="${showMessage == 4}">selected</c:if>>4</option>
                <option value="8" <c:if test="${showMessage == 8}">selected</c:if>>8</option>
                <option value="12" <c:if test="${showMessage == 12}">selected</c:if>>12</option>
                <option value="16" <c:if test="${showMessage == 16}">selected</c:if>>16</option>
                <option value="10000" <c:if test="${showMessage == 10000}">selected</c:if>>All</option>
              </select>
            <%@include file="/views/sharedSideBar_index_detail.jsp" %>
        </div>
        <!--Side bar edge-->
        <!--Main content-->
        <div class="col-md-9">
            <!-- Detail product section-->  
            <div class="row">
                <!--List Product Images-->
                <div class="col-6 "> 
					<div id="carouselExampleDark" class="carousel carousel-dark slide pt-3 pb-3" data-bs-ride="carousel" style="box-shadow: 0px 0px 0px 0.5px rgba(0,0,0,0.3);">
					  <ol class="carousel-indicators">
				  		<c:forEach var="item" items="${listDetailPics}" varStatus="loop">
				  			<li data-bs-target="#carouselExampleDark" data-bs-slide-to="${loop.index}" class="active" id="li-thumbnail">
                               	<img class="d-block w-100 image-sublist" src="${pageContext.servletContext.contextPath}/home/ProductImages/${item.product.category.name}/${item.picturename}" style="width: 50px;height: 50px">
				    		</li>
				  		</c:forEach>
					  </ol>
                        <div class="carousel-inner">
                        	<c:forEach var="item" items="${listDetailPics}" varStatus="loop">
					  			<div class="carousel-item <c:if test="${loop.index == 0}">active</c:if>">
                                	<img class="d-block w-100 " src="${pageContext.servletContext.contextPath}/home/ProductImages/${item.product.category.name}/${item.picturename}" style="width: 380.5px;height: 420px">
					    		</div>
					  		</c:forEach>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
				    </div>
			    </div>
                <!--List Product Images Edge-->
                <!--Select Detail Info-->
                <div class="col-6">
                    <h3>${listDetailProduct[0].product.name}</h3>
                    <span class="text-danger me-1"><b><fmt:formatNumber type="number" maxFractionDigits="3" value="${listDetailProduct[0].price * (1-listDetailProduct[0].product.discount/100)}"/></b></span>
                    <small style="text-decoration: line-through;">
                    	<b><fmt:formatNumber type="number" maxFractionDigits="3" value="${listDetailProduct[0].price}"/></b>
					</small>
                    <hr class="mt-2">
                    <table id="selectDetailInfo">
                        <tbody>
                            <tr><td colspan="2" class="pb-3">${listDetailProduct[0].product.description }</td></tr>
                            <tr><th><div>Color</div></th>
                            <th class="btnColorCss">
                                <input type="hidden" id="hiddenPriceByColor" value="${listDetailProduct[0].price}"/>
                                <input type="hidden" id="hiddenIdByColor" value="${listDetailProduct[0].detailedproductid}"/>
                                <input type="hidden" id="hiddenColor" value="${listDetailProduct[0].color}"/>
                            	<c:forEach var="item" items="${listDetailProduct}">
                            		<input type="radio" name="options" autocomplete="off" id="${item.detailedproductid}" value="${item.color}"
										 onclick="selectColor(${item.price},${item.quantity},'${item.detailedproductid}','${item.color}')">
                            		<label class="btn bg-${fn:toLowerCase(item.color)} rounded-0 border border-dark" for="${item.detailedproductid}"style="height: 30px; width: 30px;"> </label>
                            	</c:forEach>
                            </th></tr>
                            <tr><th><div>Quantity</div></th><td><div>
								<div class="number-input">
								  <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="minus"></button>
								  <input type="number" class="quantity" min="1" max="20" name="quantity" value=1 id="inputQuantity">
								  <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="plus"></button>
								</div>
                            
                            </div></td></tr>
                            <tr><th><div>Total</div></th><td><div id="totalPrice"><fmt:formatNumber type="number" maxFractionDigits="3">${listDetailProduct[0].price*(1-listDetailProduct[0].product.discount/100)}</fmt:formatNumber></div></td></tr>
                            <tr><th><div>Brand</div></th><td><div>${listDetailProduct[0].product.brand }</div></td></tr>
                            <tr><th><div>Category</div></th><td><div>${listDetailProduct[0].product.category.name }</div></td></tr>
                            <tr><th><div>In-stock</div></th><td><div id="instockInput">${listDetailProduct[0].quantity}</div></td></tr>
                        </tbody>
                    </table>
                    <hr class="mt-0">
                    <button class="btn btn-dark rounded-0" id="addToCart"><b>ADD TO CART</b></button>
                    <button class="btn btn-danger rounded-0" id="addToFavorite"><b>ADD TO <i class="fas fa-heart"></i></b></button>
                    <button class="btn btn-secondary rounded-0" id="removeFromFavorite"><b>REMOVE FROM <i class="fas fa-heart"></i></b></button>
                </div>
                <!--Select Detail Info Edge-->
            </div>
            <!-- Detail product section Edge-->    
            <!-- Product Description-->
            <nav class="mt-5">
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                  <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">Description</button>
                  <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">Reviews</button>
                  <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">Others</button>
                </div>
              </nav>
              <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">...</div>
                <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">...</div>
                <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">...</div>
              </div>
            <!-- Product Description Edge-->
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
        $(document).ready(function(){
            $('#inputGroupSelect02').hide();
            $('#checkYourOrder').click(function(){
                console.log("log running");
                window.location = "${pageContext.servletContext.contextPath}/detail/Cart/Log";
            })
            $(".language").on("click", function() {
                var param = $(this).prop("href");
                console.log(param);
                $.ajax({
                    url : "${pageContext.servletContext.contextPath}/detail/${listDetailProduct[0].product.productID}" + param,
                    success : function() {
                        location.reload();
                    }
                });
            })
        })
        function selectColor(price,quantity,id,color){
            $('#inputQuantity').val(1);
            $('#inputQuantity').attr('max',quantity);
            $('#instockInput').text(quantity);
            $('#hiddenPriceByColor').val(price);
            $('#hiddenIdByColor').val(id);
            $('#hiddenColor').val(color);
            $('#totalPrice').text(price.toFixed(0).replace(/(\d)(?=(\d{3})+$)/g, "$1."));
        }
        $('#inputQuantity').on('input',function(){
            var value = $(this).val();
            var unitPriceByColor = $('#hiddenPriceByColor').val();
            var max = $('#inputQuantity').attr('max');
            console.log("max: "+max);
            if(value< 1){
                $(this).val(1);
                value = 1;
            }
            // if(value> parseInt(max)){
            //     $(this).val(parseInt(max));
            //     value = parseInt(max);
            // }   
            if(value> 20){
                $(this).val(20);
                value = 20;
            }   
            $('#totalPrice').text((value* unitPriceByColor).toFixed(0).replace(/(\d)(?=(\d{3})+$)/g, "$1."));
        })
        $('.minus,.plus').on('click',function(){
            var quantity = $('#inputQuantity').val();
            var unitPriceByColor = $('#hiddenPriceByColor').val();
            $('#totalPrice').text((quantity*unitPriceByColor).toFixed(0).replace(/(\d)(?=(\d{3})+$)/g, "$1."));
        })
        $(document).ready(function() {
            $('#addToCart').click(function() {
                var productDetailedID = $('#hiddenIdByColor').val();
                var color = $('#hiddenColor').val();
                var quantity = $('#inputQuantity').val();
                var price = $('#hiddenPriceByColor').val();
                var productID = "${listDetailProduct[0].product.productID }";
                var isDeleted = "false";
                var params = "detailedproductid="+productDetailedID+"&color="+color+"&quantity="+quantity+"&price="+price+"&isDeleted="+isDeleted+"&productID="+productID;
                $.ajax({
                type:"POST",
                url: "${pageContext.request.contextPath}/detail/Cart/AddToCart/?"+params,
                async: true,
                    success: function(res){
                         $('#cartQuantity').text(res);
                    },
                });
                console.log({productDetailedID,color,quantity,price,isDeleted});
            })
            $('#addToFavorite').click(function(){
                var productID = "${listDetailProduct[0].product.productID }";
                location.href = "${pageContext.request.contextPath}/detail/Cart/AddToFavorite/"+productID
            }) 
            $('#removeFromFavorite').click(function(){
                var productID = "${listDetailProduct[0].product.productID }";
                location.href = "${pageContext.request.contextPath}/detail/Cart/removeFromFavorite/"+productID
            }) 
            $('#myFavoriteList').click(function() {
            console.log("fav running");
            window.location = "${pageContext.servletContext.contextPath}/detail/Cart/FavoriteList";
        })
        });
        
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
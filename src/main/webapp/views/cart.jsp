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
                    <a class="language" href="${pageContext.servletContext.contextPath}/detail/Cart/CartInfo?lang=vi"><i class="vietnam flag"></i></a>
                    <a class="language" href="${pageContext.servletContext.contextPath}/detail/Cart/CartInfo?lang=en"><i class="united states flag"></i></a>
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
        <div class="col-md-9">
            <div class="card">
                <div class="table-responsive">
                    <table class="table table-borderless table-shopping-cart">
                        <thead class="text-muted">
                            <tr class="small text-uppercase">
                                <th scope="col">Product</th>
                                <th scope="col" width="120">Quantity</th>
                                <th scope="col" width="120">Price</th>
                                <th scope="col" width="120">Discount</th>
                                <th scope="col" width="120">Total</th>
                                <th scope="col" class="text-end d-noned d-md-block m-0" width="200"></th>
                            </tr>
                        </thead>
                        <tbody id="cartDetail">
                        	<c:forEach var="item" items="${sessionScope['scopedTarget.cart'].getCartItems()}">
                        		<tr class="tr-${item.detailedproductid}">
									<td>
	                                    <figure class="figure d-flex align-items-center">
	                                        <div class="aside">
	                                            <img src="${pageContext.servletContext.contextPath}/home/ProductImages/${item.product.category.name}/${item.product.picture}" alt="" style="width:60px;height:80px"/>
	                            			</div>
	                                        <figcaption class="figure-caption ms-3"> <a href="" class="title text-dark" data-abc="true">${item.product.name}</a>
	                                            <p class="text-muted">COLOR: <label class="bg-${item.color} border border-1 border-dark" style="width:15px;height: 15px"></label> <br> Brand: ${item.product.brand}</p>
	                                        </figcaption>
	                                    </figure>
	                                </td>
	                                <td> <input type="number" min=1 value="${item.quantity}" max="20"
                                        oninput="updateMyQuantity('${item.detailedproductid}','${item.price}','${item.product.discount}',this)"
                                         id="getCurrentQuantity" class="text-center quantity${item.detailedproductid}" required/></td>
	                                <td>
	                                    <div class="price-wrap"> <var class="price">
	                                    	<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.price*(1-item.product.discount/100)}"/>  
	                                    </var> 
	                                    <small class="text-muted">
	                                    	<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.price}"/>
	                                    </small> </div>
	                                </td>
	                                <td>${item.product.discount}%</td>
	                                <td><b id="${item.detailedproductid}"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.price*item.quantity*(1-item.product.discount/100)}"/></b></td>
	                                <td class="text-end d-none d-md-block"> <a data-original-title="Save to Wishlist" title="" href="${pageContext.servletContext.contextPath}/detail/Cart/AddToFavorite/${item.product.productID}" class="btn btn-light" data-toggle="tooltip" data-abc="true"> <i class="fa fa-heart" style="font-size: 18px"></i></a> 
	                                <button class="btn btn-light fw-bold" data-abc="true" type="button" style="font-size:14px" onclick="removeItem('${item.detailedproductid}')"> Remove</button> </td>  
	                            </tr>
                        	</c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!--Side bar edge-->
        <!--Main content-->
        <div class="col-md-3">
            <div class="card mb-3">
                <div class="card-body">
                    <form>
                        <div class="form-group"> <label>Have coupon?</label>
                            <div class="input-group"> <input type="text" class="form-control coupon py-0" name="" placeholder="Coupon code"> <span class="input-group-text p-0"> <button class="btn btn-primary btn-apply rounded-0">Apply</button> </span> </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="card">
                <div class="card-body">
                    <dl class="dlist-align">
                        <dt>Total price:</dt>
                        <dd class="text-end ms-3" id="toTalPrice"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sessionScope['scopedTarget.cart'].getTotal()}"/> </dd>
                    </dl>
                    <dl class="dlist-align">
                    <c:forEach items="">
                    </c:forEach>
                        <dt>Discount:</dt>
                        <dd class="text-end text-danger ms-4" id="toTalDiscount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sessionScope['scopedTarget.cart'].getTotalDiscount()}"/> </dd></dd>
                    </dl>
                    <dl class="dlist-align">
                        <dt>Total:</dt>
                        <dd class="text-end text-dark ms-5" id="toTalPriceAfterDiscount"><strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${sessionScope['scopedTarget.cart'].getTotal()-sessionScope['scopedTarget.cart'].getTotalDiscount()}"/> </dd></strong></dd>
                    </dl>
                    <hr>
                     <button class="btn btn-out bg-red btn-square btn-main"data-abc="true" type="button" onclick="removeCart()"> Remove Cart </button>
                     <button class="btn btn-out btn-primary btn-square btn-main mt-2"data-abc="true" type="button" id="makePurchased"> Make Purchase </button>
                     <a class="btn btn-out btn-success btn-square btn-main mt-2" data-abc="true" type="button" href="${pageContext.servletContext.contextPath}">Continue Shopping</a>
                </div>
            </div>
        </div>
        <!--Main content Edge-->
    </div>
    <!-- Container edge-->
    <!-- Footer-->
    <div class="footer mt-5 pt-5">
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
<!-- <div class="showModal">
    <div id="myModal" class="modal messageModal">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header justify-content-center">
                    <div class="icon-box">
                        <i class="material-icons">&#xe002;</i>
                    </div>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true" id="close1">&times;</button>
                    </div>
                    <div class="modal-body text-center">
                        <h4>${sessionScope.message }</h4>
                        <button class="btn btn-success" data-bs-dismiss="modal" id="close2"><span>OK</span> <i class="material-icons">&#xE5C8;</i></button>
                    </div>
            </div>
        </div>
    </div> 
</div> -->
<script>
    $(document).ready(function() {
        $('#makePurchased').click(function(){
             window.location = "${pageContext.servletContext.contextPath}/detail/Cart/CheckLogin"
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
				url : "${pageContext.servletContext.contextPath}/detail/Cart/CartInfo/" + param,
				success : function() {
					location.reload();
				}
			});
		})
    })
    function updateMyQuantity(id,price,discount,obj){
        var quantity = obj.value;
        if(parseInt(quantity) <1 || obj.length===0){
            $('.quantity'+id).val(1);
            quantity = 1;
        }
        if(parseInt(quantity) >20){
            $('.quantity'+id).val(20);
            quantity = 20;
        }
        $('#'+id).text(numberWithDot(quantity*price*(1-discount/100)));
        var params = "detailedproductid="+id+"&quantity="+quantity;
        $.ajax({
            type: "POST",
            url:'${pageContext.request.contextPath}/detail/Cart/UpdateCart/?'+params,
            dataType:'json',
            async: true,
            success:function(data){
                reUse(data);
            }
        })
    
    }
    function removeItem(id){
        var params = "detailedproductid="+id;
        $.ajax({
            type: "POST",
            url:'${pageContext.request.contextPath}/detail/Cart/RemoveItem/?'+params,
            dataType:'json',
            async: true,
            success:function(data){
                reUse(data);
                $('.tr-'+id).remove();
            }
        })
    }
    function removeCart(){
        $.ajax({
            type: "POST",
            url:'${pageContext.request.contextPath}/detail/Cart/RemoveCart',
            dataType:'json',
            async: true,
            success:function(data){
                reUse(data);
                $('#cartDetail').remove();
            }
        })
    }
    function numberWithDot(x) {
        return parseFloat(x).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ".");
    }
    function reUse(data)   {
        $('#cartQuantity').text(data[0]);
        $('#toTalPrice').text(numberWithDot(data[1]));
        $('#toTalDiscount').text(numberWithDot(data[2]));
        $('#toTalPriceAfterDiscount>strong').text(numberWithDot(parseFloat(data[1])-parseFloat(data[2])));
    }
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
<c:if test="${sessionScope.messageModal == 'OK'}">
    <jsp:include page="/views/messageModal/messageModal.jsp"></jsp:include>
    <script>
        $(document).ready(function(){
            $('#purchasedConfirm').modal('show'); 

            $('#closeConfirmed1 ,#closeConfirmed2').click(function() {
                <% session.removeAttribute("messageModal");%>
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
    <!-- Profile Include Session -->

    <!-- Profile Include Session Edge-->
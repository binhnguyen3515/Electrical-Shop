<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://cdn.datatables.net/datetime/1.1.1/js/dataTables.dateTime.min.js"></script>
<style>
    .card{
        box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
        transition: all 0.3s cubic-bezier(.25,.8,.25,1);
    }
    .card:hover{
        box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
    }
    .page-item.active .page-link{
        background-color: #6C757D;
        border-color: #6C757D;
    }
    .page-link{
        color:#6C757D ;
    }
    .page-link:hover{
        color:#ffffff ;
        background-color: #FD7E14;
    }
    table tbody tr th{
        vertical-align: middle;
    }
    table tbody tr:hover{
        background-color: #b8b5b3;
    }
    /*Edit for same height*/

    .thirdRowContent .col-md-3,.thirdRowContent .col-md-4,.thirdRowContent .col-md-5,
    .firstRowContent .col-md-4, .secondRowContent .col-md-6{
        display:flex;
    }
    .thirdRowContent .card,.firstRowContent .card,.secondRowContent .card{
        width: 100%;
        display: flex;
        flex-direction: column;
    }
    /*Edit for same height edge*/
    .barchartFavoriteCountByType{
        vertical-align:middle;
    }
    /* .col-md-6 .card .card-header{
        background-color: white;
        position:absolute;
        top: 10px;
        z-index: 999;
    } */
    /* .col-md-6 .card{
        background-color: white;
        position:relative;
        display: block;
        
    }
    .col-md-6 .card .card-body{
        background-color: white;
        position:relative;
        
    }
    .col-md-6 .card .card-body table{
        position: absolute;
        top: 50px;
    } */
</style>
<body>
    <div class="row firstRowContent">
        <div class="col-md-4 my-1">
            <div class="card border-0 mb-2">
                <div class="card-header bg-white border-0">
                    <h5 class="card-title text-white badge bg-primary fs-6 mb-0">
                        Number Of Visitors
                        
                    </h5>
                    <small class="d-block">Last 7 days</small>
                </div>
                <div class="card-body pt-0">
                    <canvas id="myLineChartVisitors"></canvas>
                </div>
            </div>
        </div>
        <div class="col-md-4 my-1">
            <div class="card border-0 mb-2">
                <div class="card-header bg-white border-0">
                    <h5 class="card-title text-white badge bg-primary fs-6 mb-0">
                        Revenue
                    </h5>
                    <small class="d-block">Last 7 days</small>
                </div>
                <div class="card-body pt-0">
                    <canvas id="myLineChartRevenue"></canvas>
                </div>
            </div>
        </div>
        <div class="col-md-4 my-1">
            <div class="card border-0 mb-2">
                <div class="card-header bg-white border-0">
                    <h5 class="card-title text-white badge bg-primary fs-6 mb-0">
                        Number of Products Sold By Categories
                    </h5>
                    <small class="d-block">Last 7 days</small>
                </div>
                <div class="card-body pt-0">
                    <canvas id="myBarChartSoldByType"></canvas>
                </div>
            </div>
        </div>
    </div>
    <div class="row my-1 secondRowContent">
        <div class="col-md-6 my-1">
            <div class="card">
                <div class="card-header bg-white border-0 pb-0">
                    <h5 class="card-title text-white badge bg-green fs-6 mb-0">
                        Top Favorite Products
                    </h5>
                    <small class="d-block">Updated by days</small>
                </div>
                <div class="card-body pt-0">
                    <div class="table-responsive">
                        <table class="table" id="topFavoriteTable">
                            <thead class="bg-secondary text-white">
                                <tr>
                                    <th>#</th><th>Picture</th><th>Name</th><th>Brand</th><th>Type</th><th class="text-end">Likes</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${topFavoriteProducts}" varStatus="loop">
                                    <tr>
                                        <th>${loop.index+1}</th>
                                        <th><img src="${pageContext.servletContext.contextPath}/home/ProductImages/${item[3]}/${item[0] }" height="30px"/></th>
                                        <th>${item[1]}</th>
                                        <th>${item[2]}</th>
                                        <th>${item[3]}</th>
                                        <th class="text-end"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${item[4]}"/></th>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 my-1">
            <div class="card">
                <div class="card-header bg-white border-0 pb-0">
                    <h5 class="card-title text-white badge bg-green fs-6 mb-0">
                        Top Customers
                    </h5>
                    <small class="d-block">Updated by days</small>
                </div>
                <div class="card-body pt-0">
                    <div class="table-responsive">
                        <table class="table" id="topCustomerTable">
                            <thead class="bg-secondary text-white">
                                <tr>
                                    <th>#</th><th>Photo</th><th>Name</th><th>Gender</th><th>Phone</th><th class="text-end">Total Payment</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${topCustomers}" varStatus="loop">
                                    <tr>
                                        <th>${loop.index+1}</th>
                                        <th><img src="${pageContext.servletContext.contextPath}/home/userAvatar/${item[0] }" height="30px" width="30px" class="border border-2 border-dark rounded-circle"/></th>
                                        <th>${item[1]}</th>
                                        <th>${item[2]?'Male':'Female'}</th>
                                        <th>${item[3]}</th>
                                        <th class="text-end"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${item[4]}"/></th>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row mt-2 thirdRowContent">
        <div class="col-md-5 my-1">
            <div class="card">
                <div class="card-header bg-white border-0 pb-0 d-flex justify-content-between">
                    <h5 class="card-title text-white badge bg-purple fs-6 mb-0">
                        Revenue by Date
                    </h5>
                    <form class="inputGroup text-end" action="${pageContext.request.contextPath}/admin/statistics">
                        <input type="date" name="dateARevenue" id="dateARevenue" value="${dateARevenue}" required>
                        <input type="date" name="dateBRevenue" id="dateBRevenue" value="${dateBRevenue}" required>
                        <button class="px-2"><i class="fas fa-search"></i></button>
                        <button class="px-2" type="button" id="refreshRevenueByDate"><i class="fas fa-sync-alt"></i></button>
                    </form>
                </div>
                <div class="card-body pt-0">
                    <div class="table-responsive">
                        <table class="table" id="revenueByDateRangeTable">
                            <thead class="bg-secondary text-white">
                                <tr>
                                    <th>#</th><th>Date</th><th>Status</th><th class="text-end">Total Revenue</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${findRevenueByDateRange}" varStatus="loop">
                                    <tr>
                                        <th>${loop.index+1}</th>
                                        <th><fmt:formatDate pattern = "dd-MM-yyyy" value = "${item[0]}" /></th>
                                        <th>${item[2]}</th>
                                        <th class="text-end"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${item[1]}"/></th>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4 my-1">
            <div class="card">
                <div class="card-header bg-white border-0 pb-0 d-flex justify-content-between">
                    <h5 class="card-title text-white badge bg-purple fs-6 mb-0">
                        Category
                    </h5>
                    <form method="post" class="inputGroup text-end" action="${pageContext.request.contextPath}/admin/statistics/addCategory">
                        <input type="text" id="categoryName" name="categoryName" placeholder="Enter category name" required>
                        <button class="px-2 addNewCategory"><i class="fas fa-plus"></i></button>
                    </form>
                </div>
                <div class="card-body pt-0">
                    <div class="table-responsive">
                        <table class="table" id="categoryManage">
                            <thead class="bg-secondary text-white">
                                <tr>
                                    <th>#</th><th>ID</th><th>Name</th><th class="text-end">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${listCate}" varStatus="loop">
                                    <tr>
                                        <th>${loop.index+1}</th>
                                        <th>${item.categoryID}</th>
                                        <th>${item.name}</th>
                                        <th class="text-end">
                                            <a href="${pageContext.request.contextPath}/admin/statistics/removeCategory/${item.categoryID}" class="px-2 bg-danger text-white" style="cursor: pointer;"><i class="far fa-trash-alt"></i></a>
                                        </th>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 my-1">
            <div class="card border-0">
                <div class="card-header bg-white border-0">
                    <h5 class="card-title text-white badge bg-purple fs-6 mb-0">
                        Favorite Count
                    </h5>
                </div>
                <div class="card-body pt-0 barchartFavoriteCountByType d-flex align-items-center">
                    <canvas id="myFavoriteProductByCateChart" height="220"></canvas>
                </div>
            </div>
        </div>
    </div>
</body>
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
<script>
    
    $(document).ready(function(){
        
        var table = $('#topFavoriteTable,#topCustomerTable').DataTable( {
            "searching":false,
            "bLengthChange": false,
    		"pageLenght": 5,
      	    "lengthMenu": [ 5, 10, 25, 40, 100 ]
      	} );
        
        var tableRevenue = $('#revenueByDateRangeTable,#categoryManage').DataTable( {
            "searching":false,
            "bLengthChange": false,
            "pageLenght": 5,
      	    "lengthMenu": [ 5, 10, 25, 40, 100 ]
        })
        //Refilter the table
        $('#dateARevenue, #dateBRevenue').on('change', function () {
            console.log($('#dateARevenue').val());
            console.log($('#dateBRevenue').val());
            tableRevenue.draw();
        });

        $('#refreshRevenueByDate').click(function () {
            location.href = "${pageContext.request.contextPath}/admin/statistics";
        })
 
    })
    // data use for visitor line chart
    var dateListVisitors = [
        <c:forEach var="item" items="${visitorsLast7Days}">
            '<fmt:formatDate pattern = "dd/MM" value = "${item[0]}" />',
        </c:forEach>
    ]
    var numberOfVisitors = [
        <c:forEach var="item" items="${visitorsLast7Days}">
            '<c:out value="${item[1]}"/>',
        </c:forEach>
    ]

    
    var lineChartVisitor = document.getElementById('myLineChartVisitors').getContext('2d');
    var gradient = lineChartVisitor.createLinearGradient(0, 0, 0, 400);
        // gradient.addColorStop(0, 'rgba(255, 99, 132,0.7)');   
        gradient.addColorStop(0, 'rgba(75, 192, 192,0.7)');
        gradient.addColorStop(1, 'rgba(255, 99, 132,0.7)');
    var myChart = new Chart(lineChartVisitor, {
        type: 'line',
        data: {
            labels: dateListVisitors,
            datasets: [{
                // label: '# of Votes',
                data: numberOfVisitors,
                // backgroundColor: colorArrays1,
                // borderColor: colorArrays1,
                backgroundColor: ['rgb(75, 192, 192,0.7)'],//green
                borderColor: ['rgb(75, 192, 192,1)'],//green
                fill: true,
                lineTension:0,
                borderWidth: 3
            }]
        },
        options: {
            indexAxis: 'x',
            scales: {
                y: {
                    beginAtZero: true
                }
            },
            responsive: true,
            plugins: {
                title: {
                    display: false,
                    text: 'Number of Product By Category Name',
                    padding: {
                        bottom: 30,
                    },
                    font:{
                        size:20
                    }
                },
                legend: {
                display:false
                },
			
	        },
        }
    });
    //visitor line chart edge

    // data use for revenue line chart
    var dateListRevenue = [
        <c:forEach var="item" items="${revenueLast7Days}">
            '<fmt:formatDate pattern = "dd/MM" value = "${item[0]}" />',
        </c:forEach>
    ]
    var revenueListByDays = [
        <c:forEach var="item" items="${revenueLast7Days}">
            '<c:out value="${item[1]}"/>',
        </c:forEach>
    ]
    var lineRevenueChart = document.getElementById('myLineChartRevenue').getContext('2d');
    var myChart = new Chart(lineRevenueChart, {
        type: 'line',
        data: {
            labels: dateListRevenue,
            datasets: [{
                // label: 'User By Roles',
                data: revenueListByDays,
                backgroundColor: [
                'rgb(54, 162, 235,0.7)',//blue
                'rgb(201, 203, 207,0.7)',//gray
                'rgb(255, 205, 86,0.7)',//yellow
                'rgb(75, 192, 192)',//green
                'rgb(255, 99, 132)',//red
                ],
                borderColor: ['rgb(54, 162, 235,1)'],//green
                fill: true,
                lineTension:0,
                borderWidth: 3
            }]
        },
        options: {
            indexAxis: 'x',
            scales: {

            },
            responsive: true,
            plugins: {
                title: {
                    display: false,
                    // text: 'Number of Registered Users By Roles',
                    padding: {
                        bottom: 30,
                    },
                    font:{
                        size:20
                    }
                },
                legend: {
                display:false
                },
			
	        },
        }
    });
    //Revenue line chart edge
    // data use for line chart
    var productTypeList = [
        <c:forEach var="item" items="${numberOfProductSoldByType}">
            '<c:out value="${item[0]}"/>',
        </c:forEach>
    ]
    var numberSoldByType = [
        <c:forEach var="item" items="${numberOfProductSoldByType}">
            '<c:out value="${item[1]}"/>',
        </c:forEach>
    ]
    var barChartSoldByType = document.getElementById('myBarChartSoldByType').getContext('2d');
    // var gradient = pieChart.createLinearGradient(0, 0, 0, 600);
    //     gradient.addColorStop(0, 'rgba(255,0,212,0.7)');   
    //     gradient.addColorStop(1, 'rgba(123,149,198,1)');
    var myChart = new Chart(barChartSoldByType, {
        type: 'bar',
        data: {
            labels: productTypeList,
            datasets: [
            {
                data: numberSoldByType,
                backgroundColor: [
                // 'rgb(54, 162, 235,0.7)',//blue
                'rgb(255, 99, 132,0.7)',//red
                // 'rgb(255, 205, 86,0.7)',//yellow
                // 'rgb(75, 192, 192,0.7)',//green
                // 'rgb(201, 203, 207,0.7)',//gray
                ],
                borderColor: [
                // 'rgb(54, 162, 235,1)',//blue
                'rgb(255, 99, 132,1)',//red
                // 'rgb(255, 205, 86,1)',//yellow
                // 'rgb(75, 192, 192,1)',//green
                // 'rgb(201, 203, 207,1)',//gray
                ],
                fill: true,
                lineTension: 0.3,
                borderWidth: 3,
                
            }
        ]
        },
        options: {
            indexAxis: 'x',
            scales: {
                y: {
                    beginAtZero: true
                }
            },
            responsive: true,
            plugins: {
                title: {
                    display: false,
                    text: 'Payment status last 7 days',
                    padding: {
                        bottom: 10,
                    },
                    font:{
                        size:20
                    }
                },
                legend: {
                    display:false,
                },
			
	        },
        }
    });
    //line chart edge

    //data for favoriteProductByCategory 
    var productTypeList = [
        <c:forEach var="item" items="${listProductLikedByType}">
            '<c:out value="${item[0]}"/>',
        </c:forEach>
    ]
    var quantityFavoriteProductByCateGory = [
        <c:forEach var="item" items="${listProductLikedByType}">
            '<c:out value="${item[1]}"/>',
        </c:forEach>
    ]
    var barChartFavoriteByCate = document.getElementById('myFavoriteProductByCateChart').getContext('2d');
    // var gradient = pieChart.createLinearGradient(0, 0, 0, 600);
    //     gradient.addColorStop(0, 'rgba(255,0,212,0.7)');   
    //     gradient.addColorStop(1, 'rgba(123,149,198,1)');
    
    

    var myChart = new Chart(barChartFavoriteByCate, {
        type: 'bar',
        data: {
            labels: productTypeList,
            datasets: [
            {
                data: quantityFavoriteProductByCateGory,
                backgroundColor: [
                'rgb(54, 162, 235,0.7)',//blue
                'rgb(255, 99, 132,0.7)',//red
                'rgb(255, 205, 86,0.7)',//yellow
                'rgb(75, 192, 192,0.7)',//green
                'rgb(201, 203, 207,0.7)',//gray
                ],
                borderColor: [
                'rgb(54, 162, 235,1)',//blue
                'rgb(255, 99, 132,1)',//red
                'rgb(255, 205, 86,1)',//yellow
                'rgb(75, 192, 192,1)',//green
                'rgb(201, 203, 207,1)',//gray
                ],
                fill: true,
                lineTension: 0.3,
                borderWidth: 3,
                
            }
        ]
        },
        options: {
            indexAxis: 'y',
            scales: {
                y: {
                    beginAtZero: true,
                },
                
            },
            layout:{
                padding:0
            },
            responsive: true,
            plugins: {
                
                title: {
                    display: true,
                    text: '',
                    padding: {
                        bottom: 0,
                        top:0,
                    },
                    font:{
                        size:20
                    },
                    position:'bottom',
                },
                legend: {
                    display:false,
                },
			
	        },
        }
    });
    //data for favoriteProductByCategory Edge
    //set global fontweight for labels array
    Chart.defaults.font.weight = '600';
    // color depend on size of charts
    var colorArrays1 = '#F6BA09';
    function getRandomSingleColor() {
        
        var letters = '0123456789ABCDEF'.split('');
        var color = '#';
        for (var i = 0; i < 6; i++ ) {
            color += letters[Math.floor(Math.random() * 16)];
        }
        return color;
    }
    function getRandomMultiColor(){
        var randomColor = '#'+ Math.floor(Math.random() * 19777215).toString(16);
        var rgb = [];
        for (var i = 0; i < list.length; i++ ) {
            rgb.push('#'+ Math.floor(Math.random() * 19777215).toString(16));
        }
        console.log(randomColor);
        console.log(rgb);
        return rgb;
    }

</script>
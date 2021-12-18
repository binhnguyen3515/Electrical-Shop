<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<style>
    
    .summaryInfo .col-md-3 .card{
        color: whitesmoke;
        position: relative;
    }
    .summaryInfo .col-md-3 i{
        width:60px;
        position:absolute;
        right:0;
        height:100%;
        line-height: 100px;
        text-align: center;
        font-size: 30px;
        color: white;
        background-color: rgba(0,0,0,.1);
    }
    #secondRow,.summaryInfo .col-md-3 .card{
        box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
        transition: all 0.3s cubic-bezier(.25,.8,.25,1);
    }
    #secondRow:hover,.summaryInfo .col-md-3 .card:hover{
        box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
    }
    .relative {
        position: relative;
    }

    .absolute-center {
        position:absolute;
        top: 60%;
        left: 50%;
        transform: translate(-50%, -50%);
    }

    .text-center{
        text-align: center;
    }
    .percentage{
        font-size: 3rem;
    }

    .highestRole {
        font-size: 2rem;
    }
    
    @media screen and(max-width: 1000px) {
        .percentage{
            font-size: 2rem !important;
        }
        
        .highestRole {
            font-size: 1rem !important;
        }
    }
    /* .listChart{
        display: grid;
        grid-gap: var(--spacing);
        grid-template-columns: repeat(auto-fit,minmax(250px,1fr));
        grid-template-columns: 3fr 2fr;
        grid-template-columns: 68% 32%;
        box-sizing: border-box;
    } */
</style>
<body>
    <div class="summaryInfo row">
        <div class="col-md-3 ">
            <div class="card bg-green rounded-0 mb-1">
                <h2 class="fw-bold ps-2 mt-1 mb-0"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${firstRow.pendingToday}"/></h2>
                <div class="ps-2 mt-1">NEW ORDERS</div>
                <h4 class="ps-2 mt-1">Total: <fmt:formatNumber type="number" maxFractionDigits ="3" value ="${firstRow.allPending}"/></h4>
                <i class="fas fa-shopping-cart"></i>
            </div>
        </div>
        <div class="col-md-3 ">
            <div class="card bg-aqua rounded-0 mb-1">
                <h2 class="fw-bold ps-2 mt-1 mb-0"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${firstRow.todayVisitor}"/></h2>
                <div class="ps-2 mt-1">VISITORS</div>
                <h4 class="ps-2 mt-1">Total: <fmt:formatNumber type="number" maxFractionDigits ="3" value ="${firstRow.totalVisitor}"/></h4>
                <i class="fas fa-eye"></i>
            </div>
        </div>
        <div class="col-md-3 ">
            <div class="card bg-yellow1 rounded-0 mb-1">
                <h2 class="fw-bold ps-2 mt-1 mb-0"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${firstRow.todayIncome}"/></h2>
                <div class="ps-2 mt-1">INCOME</div>
                <h4 class="ps-2 mt-1">Total: <fmt:formatNumber type="number" maxFractionDigits ="3" value ="${firstRow.totalIncome}"/></h4>
                <i class="fas fa-money-bill"></i>
            </div>
        </div>
        <div class="col-md-3 ">
            <div class="card bg-red rounded-0">
                <h2 class="fw-bold ps-2 mt-1 mb-0"><fmt:formatNumber type="number" maxFractionDigits ="3" value ="${firstRow.totalAccount}"/></h2>
                <div class="ps-2 mt-1">TOTAL ACCOUNT</div>
                <h4 class="ps-2 mt-1">Banned: <fmt:formatNumber type="number" maxFractionDigits ="3" value ="${firstRow.totalAccountBanned}"/></h4>
                <i class="fas fa-users"></i>
            </div>
        </div>
    </div>
    <div class="row " style="padding: 12px;">
        <div class="col px-0">
            <div class="row">
                <div class="col-md-8 mt-2">
                    <div class="pt-3" style="background-color:#FFFFFF" id="secondRow">
                        <canvas id="myBarChart" height="147"></canvas>
                    </div>
                </div>
                <div class="col-md-4 mt-2">
                    <div class="pt-3 relative" style="background-color:#FFFFFF" id="secondRow">
                        <canvas id="myPieChart" height="150"></canvas>
                        <div class="absolute-center text-center">
                            <p class="percentage text-danger fw-bold mb-0">Some text</p>
                            <p class="highestRole text-danger fw-bold">Some text</p>
                          </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row" style="padding: 12px;">
        <div class="col px-0">
            <div class="pt-3" style="background-color:#FFFFFF" id="secondRow">
                <canvas id="myLineChart" height="50"></canvas>
            </div>
        </div>
    </div>
</body>
<script>
    // data use for bar chart
    var categoryNames = [
        <c:forEach var="item" items="${secondRowBarchart}">
            '<c:out value="${item[0]}"/>',
        </c:forEach>
    ]
    var quantitiesByCategoryNames = [
        <c:forEach var="item" items="${secondRowBarchart}">
            '<c:out value="${item[1]}"/>',
        </c:forEach>
    ]

    
    var barChart = document.getElementById('myBarChart').getContext('2d');
    var gradient = barChart.createLinearGradient(0, 0, 0, 600);
        gradient.addColorStop(0, 'rgba(255,0,212,0.7)');   
        gradient.addColorStop(1, 'rgba(123,149,198,1)');
    var myChart = new Chart(barChart, {
        type: 'bar',
        data: {
            labels: categoryNames,
            datasets: [{
                // label: '# of Votes',
                data: quantitiesByCategoryNames,
                // backgroundColor: colorArrays1,
                // borderColor: colorArrays1,

                backgroundColor  : gradient,
                strokeColor : "#ff6c23",
                pointColor : "#fff",
                pointStrokeColor : "#ff6c23",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "#ff6c23",

                borderWidth: 1
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
                    display: true,
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
    //bar chart edge

    // data use for Doughnut chart
    $(document).ready(function() {
        var numberOfUserByRole = [];
        var theArray = [];
        var getTheHighest = [];
        var totalUsers = 0;
        <c:forEach var="item" items="${secondRowPolarchart}">
            numberOfUserByRole.push(${item[1]})
            theArray.push(["${item[0]}",${item[1]}])
        </c:forEach>
        theArray.forEach(e => {
            totalUsers += e[1];
            if(Math.max(...numberOfUserByRole) === e[1]){
                getTheHighest.push(e);

            }
        });
        console.log("totalUser: "+totalUsers);
        var percentage = (getTheHighest[0][1]/totalUsers)*100;
        $('.percentage').text(Math.round(percentage)+" %");
        $('.highestRole').text(getTheHighest[0][0]);
    })

    var roleNames = [
        <c:forEach var="item" items="${secondRowPolarchart}">
            '<c:out value="${item[0]}"/>',
        </c:forEach>
    ]
    var numberOfUserByRole = [
        <c:forEach var="item" items="${secondRowPolarchart}">
            '<c:out value="${item[1]}"/>',
        </c:forEach>
    ]
    var pieChart = document.getElementById('myPieChart').getContext('2d');
    var myChart = new Chart(pieChart, {
        type: 'doughnut',
        data: {
            labels: roleNames,
            datasets: [{
                label: 'User By Roles',
                data: numberOfUserByRole,
                backgroundColor: [
                'rgb(54, 162, 235,0.7)',//blue
                'rgb(201, 203, 207,0.7)',//gray
                'rgb(255, 205, 86,0.7)',//yellow
                'rgb(75, 192, 192)',//green
                'rgb(255, 99, 132)',//red
                ],
            }]
        },
        options: {
            // cutout : 150,
            indexAxis: 'x',
            scales: {

            },
            responsive: true,
            plugins: {
                title: {
                    display: true,
                    text: 'Number of Registered Users By Roles',
                    padding: {
                        bottom: 30,
                    },
                    font:{
                        size:20
                    }
                },
                legend: {
                display:true
                },
			
	        },
        }
    });
    //Doughnut chart edge
    // data use for line chart
    var dateList = [
        <c:forEach var="item" items="${thirdRowLineChart}">
            '<fmt:formatDate pattern = "dd-MM-yyyy" 
	         value = "${item[0]}" />',
        </c:forEach>
    ]
    var pendingList = [
        <c:forEach var="item" items="${thirdRowLineChart}">
            '<c:out value="${item[1]}"/>',
        </c:forEach>
    ]
    var paidList = [
        <c:forEach var="item" items="${thirdRowLineChart}">
            '<c:out value="${item[2]}"/>',
        </c:forEach>
    ]
    var lineChart = document.getElementById('myLineChart').getContext('2d');
    // var gradient = pieChart.createLinearGradient(0, 0, 0, 600);
    //     gradient.addColorStop(0, 'rgba(255,0,212,0.7)');   
    //     gradient.addColorStop(1, 'rgba(123,149,198,1)');
    var myChart = new Chart(lineChart, {
        type: 'line',
        data: {
            labels: dateList,
            datasets: [
            {
                label: 'Pending',
                data: pendingList,
                backgroundColor: ['rgb(255, 99, 132,0.5)'],//red
                borderColor: ['rgb(255, 99, 132,1)'],//red
                fill: true,
                lineTension: 0.3,
                borderWidth: 3,
                
            },
            {
                label: 'Paid',
                data: paidList,
                backgroundColor: ['rgb(75, 192, 192,0.5)'],//green
                borderColor: ['rgb(75, 192, 192,1)'],//green
                fill: true,
                lineTension: 0.3,
                borderWidth: 3
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
                    display: true,
                    text: 'Payment status last 7 days',
                    padding: {
                        bottom: 10,
                    },
                    font:{
                        size:20
                    }
                },
                legend: {
                    display:true,
                },
			
	        },
        }
    });
    //set global fontweight for labels array
    Chart.defaults.font.weight = '600';
    //line chart edge
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
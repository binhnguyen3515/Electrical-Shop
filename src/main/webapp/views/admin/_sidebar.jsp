<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!-- <div class="sidebar close"> -->
<div class="
<c:if test="${sessionScope.closeSidebar == false || sessionScope.closeSidebar == null}">
	sidebar
</c:if>
<c:if test="${sessionScope.closeSidebar == true}">
	sidebar close
</c:if>
">
    <div class="logo-details">
        <i class='bx bx-clinic icon'></i>
        <span class="logo_name">E-Shop</span>
        <i class='bx bx-menu' id="btn"></i>
    </div>
    <ul class="nav-links">
        <li class="<c:if test="${sessionScope.onSelected == 'dashboard'}">onSelected</c:if>">
            <a href="${pageContext.servletContext.contextPath}/admin">
                <i class='bx bx-grid-alt'></i>
                <span class="link_name">Dashboard</span>
            </a>
            <ul class="sub-menu blank">
                <li><a class="link_name" href="${pageContext.servletContext.contextPath}/admin">Dashboard</a></li>
            </ul>
        </li>
        <li class="<c:if test="${sessionScope.onSelected == 'product'}">onSelected</c:if>">
            <a href="${pageContext.servletContext.contextPath}/admin/product">
                <i class='bx bx-layer'></i>
                <span class="link_name">Product</span>
            </a>
            <ul class="sub-menu blank">
                <li><a class="link_name" href="${pageContext.servletContext.contextPath}/admin/product">Product</a></li>
            </ul>
        </li>
        <li class="<c:if test="${sessionScope.onSelected == 'account'}">onSelected</c:if>">
            <a href="${pageContext.servletContext.contextPath}/admin/account">
                <i class='bx bx-user'></i>
                <span class="link_name">Account</span>
            </a>
            <ul class="sub-menu blank">
                <li><a class="link_name" href="${pageContext.servletContext.contextPath}/admin/account">Account</a></li>
            </ul>
        </li>
        <li class="<c:if test="${sessionScope.onSelected == 'statistics'}">onSelected</c:if>">
            <a href="${pageContext.servletContext.contextPath}/admin/statistics">
                <i class='bx bx-bar-chart-square'></i>
                <span class="link_name">Statistics</span>
            </a>
            <ul class="sub-menu blank">
                <li><a class="link_name" href="${pageContext.servletContext.contextPath}/admin/statistics">Statistics</a></li>
            </ul>
        </li>
        <li class="<c:if test="${sessionScope.onSelected == 'invoice'}">onSelected</c:if>">
            <a href="${pageContext.servletContext.contextPath}/admin/invoice">
                <i class='bx bx-dollar' ></i>
                <span class="link_name">Invoice</span>
            </a>
            <ul class="sub-menu blank">
                <li><a class="link_name" href="${pageContext.servletContext.contextPath}/admin/invoice">Invoice</a></li>
            </ul>
        </li>
        <li class="<c:if test="${sessionScope.onSelected == 'archived'}">onSelected</c:if>">
            <div class="iocn-link">
                <a>
                    <i class='bx bxs-trash'></i>
                    <span class="link_name">Archived</span>
                </a>
                <i class='bx bxs-chevron-down arrow' ></i>
            </div>
            <ul class="sub-menu">
                <li><a class="link_name">Archived</a></li>
                <li><a href="${pageContext.servletContext.contextPath}/admin/arhiveAccount">Account</a></li>
                <li><a href="${pageContext.servletContext.contextPath}/admin/arhiveProduct">Product</a></li>
            </ul>
        </li>
        <li>
            <div class="profile-details">
                <div class="profile-content">
                    <img src="${pageContext.servletContext.contextPath}/home/userAvatar/${sessionScope.loginInfo.photo}" alt="img">
                </div>
                <div class="name-job">
                    <div class="profile_name"><span class="_profileName" data-toggle="tooltip" title="${sessionScope.loginInfo.fullname}">${sessionScope.loginInfo.fullname}</span></div>
                    <div class="job">${sessionScope.loginInfo.role}</div>
                </div>
                <a href="${pageContext.servletContext.contextPath}/logout"><i class='bx bx-log-out'></i></a>
            </div>
        </li>
    </ul>
</div>

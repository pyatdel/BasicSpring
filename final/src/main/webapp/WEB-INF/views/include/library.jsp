<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>W7VKY 그룹웨어</title>
    <link href="/dash/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="/css/header.css"> 
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Libre+Baskerville:ital,wght@0,400;0,700;1,400&family=Marhey:wght@300..700&family=Montserrat+Alternates:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Montserrat:ital,wght@0,100..900;1,100..900&family=Quicksand:wght@300..700&family=Signika+Negative:wght@300..700&family=Slabo+27px&family=Sour+Gummy:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Libre+Baskerville:ital,wght@0,400;0,700;1,400&family=Marhey:wght@300..700&family=Montserrat+Alternates:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Montserrat:ital,wght@0,100..900;1,100..900&family=Noto+Sans+KR:wght@100..900&family=Quicksand:wght@300..700&family=Signika+Negative:wght@300..700&family=Slabo+27px&family=Sour+Gummy:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Libre+Baskerville:ital,wght@0,400;0,700;1,400&family=Marhey:wght@300..700&family=Montserrat+Alternates:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Montserrat:ital,wght@0,100..900;1,100..900&family=Noto+Sans+KR:wght@100..900&family=Quicksand:wght@300..700&family=Raleway:ital,wght@0,100..900;1,100..900&family=Signika+Negative:wght@300..700&family=Slabo+27px&family=Sour+Gummy:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
	
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- Chartjs Adapter for Date (for time scale) -->
<script
	src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns@latest"></script>

<!-- Chartjs plugin for datalabels -->
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<!-- (Optional) Google Chart Loader -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.7.7/axios.min.js"></script>

<script type="text/javascript" src="/js/jquery-3.6.0.js"></script>

	
	 <!-- Libraries Stylesheet -->
    <link href="/dash/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/dash/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
	
    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" integrity="sha512-5A8nwdMOWrSz20fDsjczgUidUBR8liPYU+WymTZP1lmY9G6Oc7HlZv156XqnsgNUzTyMefFTcsFH/tnJE/+xBg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-d5a6f6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e6b1e

<!--     Libraries Stylesheet -->
<!--     <link href="/dash/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet"> -->
<!--     <link href="/dash/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" /> -->

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/dash/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    


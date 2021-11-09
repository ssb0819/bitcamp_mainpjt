<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
</head>
<body>
<div class="container">
	<section class="mb-5">
		<div class="card bg-light">
			<div class="card-body" style=" text-align: center;">
				<img class="lazy-img" src="/static/img/loading.jpg" data-src="${project.pjtImg}" alt="추후업로드(상세이미지)"  style="max-width: 80%; min-width: 80%;" data-aos="fade-out">
				<img class="lazy-img" src="/static/img/loading.jpg" data-src="${project.policyImg}" alt="추후업로드(상세이미지)"  style="max-width: 80%; min-width: 80%;" data-aos="fade-out">
				<div class="d-flex"></div>
			</div>
		</div>
	</section>
</div>
	<script>
 window.onload = () => {
	    const observerOption = {
	        root: null,
	        rootMargin: "0px 0px 30px 0px",
	        threshold: 0.2
	    }
	    
	    // IntersectionObserver 인스턴스 생성
	    const io = new IntersectionObserver((entries, observer) => {
	        entries.forEach(entry => {
	            // entry.isIntersecting: 특정 요소가 뷰포트와 20%(threshold 0.2) 교차되었으면
	            if (entry.isIntersecting) {
	                entry.target.src = entry.target.dataset.src
	                observer.unobserve(entry.target)    // entry.target에 대해 관찰 종료
	            }
	        })
	    }, observerOption)
	    // lazy-img 클래스 요소 순회
	    const lazyImgs = document.querySelectorAll(".lazy-img")
	    lazyImgs.forEach(el => {
	        io.observe(el)  // el에 대하여 관측 시작
	    })
	}

 AOS.init();

 </script>
 
</body>
</html>
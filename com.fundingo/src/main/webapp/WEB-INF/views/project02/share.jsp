<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<!-- kakao sdk 호출 -->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>


<script type="text/javascript">
	
	
	//SDK init
	//if (!Kakao.isInitialized()){
	Kakao.init('f6290c2fa487514b2a44774253a14e0e');
	//}
	//SDK 초기화 여부를 판단합니다.
	console.log(Kakao.isInitialized());
</script>
<script type="text/javascript">
try{
  function sendLink() {	 
    Kakao.Link.sendDefault({ 
      objectType: 'commerce',
      content: {
        title: '${project.pjtPlan}',
        imageUrl:
        //url: '${project.thumbnail}',
        'http://mstatic1.e-himart.co.kr/contents/goods/00/00/66/70/62/0000667062__TF5-00006__M_640_640.jpg',
        //	'http://m.onemorebag.kr/web/upload/NNEditor/20210320/d37a287892648af8343def2a92f03ad4_shop1_174046.jpg', //임의로 넣은 주소
        //	'${project.thumbnail}', //왜 안 되냐고
         // 'http://k.kakaocdn.net/dn/dScJiJ/btqB3cwK1Hi/pv5qHVwetz5RZfPZR3C5K1/kakaolink40_original.png', //${project.thumbnail} 왜 안 될까
        link: {
          mobileWebUrl: '/project/getPjtList',
          webUrl: '/project/getPjtList',
        },
      },
      commerce: {
        productName: '${project.pjtName}',       
        regularPrice: 40000,
       // discountRate: 10,
       // discountPrice: 18000
      },
      buttons: [
        {
          title: '펀딩하기',
          link: {
            mobileWebUrl: '/project/getPjt/${project.pjtNo}',
            webUrl: '/project/getPjt/${project.pjtNo}',
          },
        },
        {
          title: '펀딩고로 가기',
          link: {
            mobileWebUrl: 'http://192.168.0.115:8080',
            webUrl: 'http://192.168.0.115:8080',
          },
        },
      ],
    })
  }
  ; window.kakaoDemoCallback && window.kakaoDemoCallback() }
  catch(e) { window.kakaoDemoException && window.kakaoDemoException(e) }
</script>
</head>
<body>
<!--<a id="kakao-link-btn" href="javascript:sendLink()">
     <img
    src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"
  /></a>--> 




</body>
</html>
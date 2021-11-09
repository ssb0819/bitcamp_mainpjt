package com.fundingo.service.project.test;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.cloud.gcp.vision.CloudVisionTemplate;
import org.springframework.core.io.ResourceLoader;
import org.springframework.transaction.annotation.Transactional;

import com.fundingo.Application;
import com.fundingo.common.Search;
import com.fundingo.service.domain.Chat;
import com.fundingo.service.domain.Favorite;
import com.fundingo.service.domain.PjtImg;
import com.fundingo.service.domain.PjtReport;
import com.fundingo.service.domain.Project;
import com.fundingo.service.domain.Review;
import com.fundingo.service.domain.User;
import com.fundingo.service.project.ProjectService;
import com.fundingo.service.project.ProjectService03;
/*import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.Block;
import com.google.cloud.vision.v1.EntityAnnotation;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.Feature.Type;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.cloud.vision.v1.Page;
import com.google.cloud.vision.v1.Paragraph;
import com.google.cloud.vision.v1.Symbol;
import com.google.cloud.vision.v1.TextAnnotation;
import com.google.cloud.vision.v1.Word;
import com.google.protobuf.ByteString;*/

@SpringBootTest
class ProjectApplicationTests {

	private static final Logger LOGGER = LogManager.getLogger(Application.class);
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private ProjectService03 projectService03;


//	@Autowired 
//	private CloudVisionTemplate cloudVisionTemplate;
	 
	

	private Project project = new Project();
	
	private Search search = new Search();
	
	private Map<String, Object> map = new HashMap<String, Object>();
	
	@Autowired
    ResourceLoader resourceLoader;

	private static final String IMG_PATH = ClassLoader.getSystemResource(".").
			getPath().
			substring(1, ClassLoader.getSystemResource("./").getPath().lastIndexOf("target"))
			+ "/src/main/resources/static/img";

	@Test
	void temp() {

		LOGGER.info(IMG_PATH);
		LOGGER.info("classpath:");
		//지우지X
	}
	
	
	//@Test
	public void testdnswjsausgj() {
		
		String temp = "1종대형 1종보8 1종소형	"
				+ "			특수(대형견인,소형견인,구난)		"
				+ "		28보동 2층소형 원동기 11-17-174133-01		"
				+ "		자동차운전연허종 (Driver's License)"
				+ "				홍길순"
				+ "				970629-2234567"
				+ "				서울특별시 서대운구 통일로"
				+ "				97 (이근동 209)"
				+ "				적성검사 2029.01.01"
				+ "				기"
				+ "				간 : - 2029.12.31"
				+ "				건 : 2보(A)"
				+ "				P70D34"
				+ "				장기· 조직기증 2019.06.01.서울지방경찰정장";

		String tnws =temp.replaceAll("(\r\n|\r|\n|\n\r|\\p{Z}|\\t)", "");
		LOGGER.info(tnws);
		Pattern pattern = Pattern.compile("\\d{6}\\-[1-4]\\d{6}");
		 Matcher matcher = pattern.matcher(tnws);
		LOGGER.info(matcher.find());
		String CI = matcher.group();
		LOGGER.info(CI);
		String[] arr = tnws.split("(Driver\'sLicense)");
		String name = arr[1].substring(1, arr[1].indexOf(CI));
		LOGGER.info(name);

		/*
		 * LOGGER.info(tempNoWhiteSpace);
		 * LOGGER.info(tempNoWhiteSpace.lastIndexOf("(Driver's License)"));
		 * LOGGER.info(tempNoWhiteSpace.substring(tempNoWhiteSpace.
		 * indexOf("(Driver's License)")+"(Driver's License)".length(),
		 * tempNoWhiteSpace.indexOf("(Driver's License)")+"(Driver's License)".length()+
		 * 3));
		 */
	}
	
	
	//@Test
	public void testalswmd() {
		String temp ="주민등록증\n"
				+ "김재현(쇼)\n"
				+ "940327-1064811\n"
				+ "서울특별시 용산구 서빙고로5\n"
				+ "1길 68-14, 102동 204호 (서\n"
				+ "빙고동, 금호베스트빌아파트)\n"
				+ "2016. 12. 12.\n"
				+ "A\n"
				+ "서울특별시 용산구청장\n";
		String tnws =temp.replaceAll("(\r\n|\r|\n|\n\r|\\p{Z}|\\t)", "");
		LOGGER.info(tnws);
		Pattern pattern = Pattern.compile("\\d{6}\\-[1-4]\\d{6}");
		Matcher matcher = pattern.matcher(tnws);
		LOGGER.info(matcher.find());
		String CI = matcher.group();
		LOGGER.info(CI);
		int start = tnws.indexOf("주민등록증")+"주민등록증".length();
		int end = start+3;
		String name = tnws.substring(start, end);
		LOGGER.info(name);
		
		
		
		
		
		
		
		
	}
	
	//@Test
	public void testbl() {
		String temp1 = " 국세청국세청사업자등록증(법인사업자)등록번호:113-86-21886법인명(단체명):주식회사미리디대표자:강창석개업연"
				+ "월일:2008년05월30일법인등록번호:110111-3902651사업장소재지:서울특별시구로구디지털로31길12,8층(구로동,태평양물산)"
				+ "본점소재지:서울특별시구로구디지털로31길12,8층(구로동,태평양물산)SERV업태|서비스EP사업의종류:종목|소프트웨어개발공급앨범,북"
				+ "제조제조업소매업통신판매서비스옥외광고업서비스현수막,명함제작,실사출력,인쇄출력발급사유:정정사업자단위과세적용사업자여부:여(V)부()("
				+ "적용일자:2019년05월13일)전자세금계산서전용전자우편주소:2021년04월15일구로세무서장|국세청국세청NationalTaxServiceOREAnts.g"
				+ "o.krNATICONA,";
		
		String temp2 = "사업자등록증(일반과세자)등록번호:104-06-31239상호:동일비"
				+ "닐포장성명:조성기개업년월일:2007년01월02일사업장소재지:서울특별시_중"
				+ "구주교동19-1방산종합시장A동'2층104~105호사업자의주소:서울특별시동대문구이문"
				+ "동64-1쌍용아파트116-151110/4사업의종류:업태도소매종목포장자재및비닐mail:c"
				+ "hosungki777@naver.comTel:02-2272-8652Fax:02-2272-86552007년"
				+ "01월08일남대문세무서장";
		
		
		String temp3 = "게국세청사업증자등록(일반과세자)52525252525등록"
				+ "번호:401-30-00345호:참조은포장:정갑주생년월일:1982년0"
				+ "3월08일개업연월일:2016년01월04일사업장소재지:서울특별시중"
				+ "구동호로33길24,2층2046호(오장동,센트마상가)종목전자상거래"
				+ "업봉투,포장자재,테이크아웃용품사업의종류:업태|도소매도소매REPUB"
				+ "LI급유:신구공동사업자:TEL:02.2274.6708FAX:02.2274.67"
				+ "09H.P:010.6299.6708E.MAIL:inhyun6708@naver.com사업"
				+ "자단위과세적용사업자여부:여()부(V)전자세금계산서전용전자우편주소:2015"
				+ "년12월28일중부세무서장UDUCNTS0국세청사상성";
		
		
		String temp5 = "국제봉사업자등록증(일반과세자)등록번호:140-11-88144호:화통치킨명:김기현생년월일"
				+ ":1978년10월06일개업연일:2014년12월18일사업장소재지:서울특별시금천구시홈대로165.1층108호"
				+ "(시흥동,남서울힐스테이트제313(1단지상가))사업의종류:업태|음식점종목|치킨급사유:정정NTS공동사"
				+ "업자:주류판매신고번호:119-5-52776사업범위:판매할주류의종류만을면허장소에서소매하여야한다.판매할"
				+ "주류의종류:주정이외의주류지정조건:1.사업범위를위반하면면허를취소한다.2.타법령에의해허가·등록이취소되면이"
				+ "면허도취소된다.사업자단위과세적용사업자여부:여()부(V)전자세금계산서전용전자우편주소:2017년04월18일금"
				+ "천세무서장DNTS국세청REA0KORE";
		
		
		String temp6 = "게국세청KOResesesace사업자등록증(법인사업자)등록번호:696-81-00760법인명("
				+ "단체명):주식회사부광어패럴대표자:유선개업연월일:2017년04월01일법인등록번호:110111-6286"
				+ "739사업장소재지:서울특별시동대문구천호대로17길20,2층(용두동)본점소재지:서울특별시동대문구천호대로1"
				+ "7길20,2층(용두동)ERVICE종목|의류,유니폼EPU사업의종류:업태|제조업NTS급사유:신규사업자단위과세적"
				+ "용사업자여부:여()부(V)전자세금계산서전용전자우편주소:2017년02월27일동대문세무서장국세청NTSOKEAOF"
				+ "NATI발www.nts.go.kr";

		
		
		
		String tnws = temp5.replaceAll("(\r\n|\r|\n|\n\r|\\p{Z}|\\t)", "");
		LOGGER.info(tnws);
		Pattern pattern = Pattern.compile("\\d{3}\\-\\d{2}\\-\\d{5}");
		

		Matcher matcher = pattern.matcher(tnws);
		boolean b = matcher.find();
		
		LOGGER.info(b);
		if(b) {
		String businessLicenseNo = matcher.group();
		LOGGER.info(businessLicenseNo);
		
			if(tnws.indexOf("법인사업자") != -1) {
				int start = tnws.indexOf("단체명")+5;
				int end = tnws.indexOf("대표자");
				String corporateName = tnws.substring(start, end);
				LOGGER.info(corporateName);
				
				String sellerName = tnws.substring(tnws.indexOf("대표자:")+4, tnws.indexOf("개업연월"));
				
				LOGGER.info(sellerName);
			}else if(tnws.indexOf("일반과세자")!=-1) {
				int start = tnws.indexOf(businessLicenseNo);
				int startSangho = tnws.indexOf(":", start)+1;
				int endSangho = tnws.indexOf(":", startSangho)-2; 
				LOGGER.info(start+"/"+startSangho + "/" + endSangho);
				String sangho = tnws.substring(startSangho, endSangho);
				String name = tnws.substring(tnws.indexOf(":", endSangho)+1, tnws.indexOf("월일", endSangho)-3);
				LOGGER.info(sangho);
				LOGGER.info(name);
				
 			}
		}
	}
	
	
	//@Test
	public void account() {
		String temp1 = "인감확인인더나은내일을위한동행,\n"
				+ "신한은행이고객님의성공을위해함께하겠습니다.\n"
				+ "님임규환for서명계좌번호110-224220050\n"
				+ "예금종류저축예금|실명확인필고객번호\n"
				+ "649967791신규일2007-09-13\n"
				+ "계좌관리점금호역통장발행점을지로\n"
				+ "5가발행번호01-02발행일2015-03-09\n"
				+ "증서번호57027584S신한은행SWIFTCO\n"
				+ "DE:SHBKKRSE통장,함부로타인에게넘겨주\n"
				+ "어서는안됩니다!모인터넷뱅킹수수료절약은기\n"
				+ "본,빠르고편리하게은행업무를!www.shinhan.c\n"
				+ "om접속인증서발급▶로그인순간의잘못된선택으\n"
				+ "로범법자가되시겠습니까?C폰뱅킹전화한통화로은\n"
				+ "행일OK!1577-8000/1599-8000해외에서이용시82\n"
				+ "-2-3449-8000타인에게통장을매매·양도하면법적처\n"
				+ "벌을받게됩니다(3년이하의징역또는2천만원이하의벌\n"
				+ "금)통장(카드)을매매·양도하는경우통장명의인은민·형사\n"
				+ "상의책임을지게됩니다.어떤경우에도다른사람에게통장(\n"
				+ "카드)을매매·양도하지마십시요![신용카드관련]1544-7000□스\n"
				+ "마트폰뱅킹스마트폰으로조회,이체,편드,외환,카드까지!인터넷\n"
				+ "뱅킹가입▶m.shinhan.com접속앱다운로드인증서로그인금융사\n"
				+ "기유형(예시)·금전제공을미끼로본인소유통장(카드)매매를요청\n"
				+ "받는경우•대출을해주겠다며미리각종수수료입금을요청받는경\n"
				+ "우•취업(아르바이트)등을미끼로통장(카드)매매·양도를요청받는\n"
				+ "경우은행거래시불편,애로사항|080-023-0182이용시간09:00~\n"
				+ "17:00(공휴일,토·일요일제외)대한민국정부인지세100원남대문\n"
				+ "세무서장후납승인제2006-2호(이통장은표지를합하여12장입니\n"
				+ "다.)(1-101-0018)(2015.1)(14.0x8.75)0.C.R지90g/㎥";
		
		String temp2="주식회사하나은행i님계좌번호(KEBHanaBank)*"
				+ "SWIFTBIC:KOEXKRSE633-10337-07307과목It"
				+ ":인감서명통장발행일2018년05월24일통장발행점둔산뉴"
				+ "타운2018년05월24일계좌개설일문산뉴타운검인계좌개설점"
				+ "인감과서명중어느하나로자금인출이가능합니다.서명으로인출"
				+ "시본인확인증표를제시하여본인확인을받으셔야합니다.042)4"
				+ "82-1111개설점KEB하나은행을이용하여주셔서감사합니다#0"
				+ "01예금신규이통장은수신거래기본약관및해당상품별거래약관이함"
				+ "께적용됩니다.서명사용자동이체및서비스내용저희은행영업점에비치"
				+ "된약관내용을확인해주시고의문사항이있으시면거래점으로문의하여주"
				+ "십시오.ATM동장출금폰뱅킹출금계품짜인터넷출금계프작통장,인감"
				+ "등을분실하셨을때에는즉시가까운저희은행으로연락하여주십시오.예"
				+ "금통장,현금카두대여·양도금지!대가를받지않아도처벌받습니다!대"
				+ "한민국정부인지세100원KEB하나은행고객센터상담/조회1599-111"
				+ "1남대문세무서장선남승인2018년1000005/0호품목코드461(14x8"
				+ ".75)O.C.R105g특이사항";
		
		String temp3="TKEB하나은행통장사본인쇄조회일시:2019-11-2810:35:39"
				+ "주식회사게이씨글로비즈하나은행376-010023-03004기업자유에금열거설잡사본으로서연감"
				+ ",서명.검인생략2018년09월12으02-323-1111KEB하나은행을이용하여주셔서감사합니다"
				+ "SWFTCODE:KOEXKASE자용이서대예금통장,현금카트데여·양도금지!대가를받지않다도처럼받습니다"
				+ "!2019-11-2310:38끼ㅜKEB하나은행기업";
		
		String temp4="";
		
	}
	
	/*
	 * //@Test public void label() {
	 * 
	 * AnnotateImageResponse response = this.cloudVisionTemplate.analyzeImage(
	 * this.resourceLoader.getResource(
	 * "http://img1.bizhows.com/bhfile01/__CM_FILE_DATA/202104/15/14/2438331_1618465806169.jpg"
	 * ), Type.LABEL_DETECTION);
	 * 
	 * Map<String, Float> imageLabels = response .getLabelAnnotationsList()
	 * .stream() .collect( Collectors.toMap( EntityAnnotation::getDescription,
	 * EntityAnnotation::getScore, (u, v) -> { throw new
	 * IllegalStateException(String.format("Duplicate key %s", u)); },
	 * LinkedHashMap::new));
	 * 
	 * 
	 * LOGGER.info(imageLabels.toString());
	 * 
	 * }
	 */
	
	
	/*
	 * @Test public void text() { String textFromImage =
	 * this.cloudVisionTemplate.extractTextFromImage(this.resourceLoader.getResource
	 * ("file:"+IMG_PATH+"/aldlswmd.jpg")); //String textFromImage =
	 * this.cloudVisionTemplate.extractTextFromImage(this.resourceLoader.getResource
	 * (
	 * "https://www.google.com/url?sa=i&url=http%3A%2F%2Fwww.pointcm.net%2F_sub06%2Fsub01_1.asp%3Fcode1%3D167&psig=AOvVaw3zDxuMvNX8_voXpA5f5JQL&ust=1627214341486000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCMivz_fT-_ECFQAAAAAdAAAAABAZ"
	 * ));
	 * 
	 * LOGGER.info("Text from image: " +
	 * textFromImage.replaceAll("(\r\n|\r|\n|\n\r|\\p{Z}|\\t)", "")); }
	 */
	
	
	/*
	 * @Test public void local() throws IOException { List<AnnotateImageRequest>
	 * requests = new ArrayList<>();
	 * 
	 * ByteString imgBytes = ByteString.readFrom(new
	 * FileInputStream(IMG_PATH.substring(1, IMG_PATH.length())+"/bl2.jpg")); Image
	 * img = Image.newBuilder().setContent(imgBytes).build(); Feature feat =
	 * Feature.newBuilder().setType(Type.DOCUMENT_TEXT_DETECTION).build();
	 * AnnotateImageRequest request =
	 * AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
	 * requests.add(request);
	 * 
	 * // Initialize client that will be used to send requests. This client only
	 * needs to be created // once, and can be reused for multiple requests. After
	 * completing all of your requests, call // the "close" method on the client to
	 * safely clean up any remaining background resources. try (ImageAnnotatorClient
	 * client = ImageAnnotatorClient.create()) { BatchAnnotateImagesResponse
	 * response = client.batchAnnotateImages(requests); List<AnnotateImageResponse>
	 * responses = response.getResponsesList(); client.close();
	 * 
	 * for (AnnotateImageResponse res : responses) { if (res.hasError()) {
	 * System.out.format("Error: %s%n", res.getError().getMessage()); return; }
	 * 
	 * // For full list of available annotations, see http://g.co/cloud/vision/docs
	 * TextAnnotation annotation = res.getFullTextAnnotation(); for (Page page :
	 * annotation.getPagesList()) { String pageText = ""; for (Block block :
	 * page.getBlocksList()) { String blockText = ""; for (Paragraph para :
	 * block.getParagraphsList()) { String paraText = ""; for (Word word :
	 * para.getWordsList()) { String wordText = ""; for (Symbol symbol :
	 * word.getSymbolsList()) { wordText = wordText + symbol.getText();
	 * System.out.format( "Symbol text: %s (confidence: %f)%n", symbol.getText(),
	 * symbol.getConfidence()); } System.out.format(
	 * "Word text: %s (confidence: %f)%n%n", wordText, word.getConfidence());
	 * paraText = String.format("%s %s", paraText, wordText); } // Output Example
	 * using Paragraph: System.out.println("%nParagraph: %n" + paraText);
	 * System.out.format("Paragraph Confidence: %f%n", para.getConfidence());
	 * blockText = blockText + paraText; } pageText = pageText + blockText; } }
	 * System.out.println("%nComplete annotation:");
	 * System.out.println(annotation.getText()); } } }
	 */
		
//	@Transactional
//	@Test
	public void addProject() {
		Project pjt = new Project();
		User user = new User();
		user.setUserNo(10000);		
		
		pjt.setUser(user);
		
		int i = projectService.addPjt(pjt);
		
		LOGGER.info("addProject(user) : "+user);
		LOGGER.info("addProject(pjt.getPjtNo()) : "+pjt.getPjtNo());
		LOGGER.info("addProject(projectService.addPjt(pjt) : " + i);

	}
	
	//@Test
	public void getPjtReport() {
		
		LOGGER.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		LOGGER.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		LOGGER.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		LOGGER.info("플젝03 테스트:"+projectService03.getPjtReport(10000));
		LOGGER.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		LOGGER.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		LOGGER.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		LOGGER.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
	}
	
	
//	@Transactional
//	@Test
	public void updateProject() {
		String type="first";
		project.setSellerType("1");
		project.setPaymentPlan("1");
		project.setPjtPlan("열심히할게요열심히할게요열심히할게요열심히할게요열심히할게요열심히할게요열심히할게요");
		project.setPjtNo(10000);
		map.clear();
		map.put("type", type);
		map.put("project", project);
	//	projectService.updatePjt(map);
		
		
		type="second";
		project.setSellerEmail("update중@naver.com");
		project.setIDImg("IDImgtestestestestestestestsetsetsetset");
		project.setSellerName("업데이트테스트");
		project.setSellerCI("업-뎃");
		project.setAccountImg("accountImgtestsetset");
		project.setBankName("업뎃은행");
		project.setAccountNo("계좌-번호");
		project.setBusinessLicenseImg("사업자등록증이미지testest");
		project.setbusinessLicenseNo("사-등-번");
		project.setCorporateName("업뎃상사");
		map.clear();
		map.put("type", type);
		map.put("project", project);
	//	projectService.updatePjt(map);
		
		type="third";
		project.setPjtImg("pjtImgtestestest");
		project.setPolicyImg("policyImgtestest");
		project.setCategory("2");
		project.setStartDate(Calendar.getInstance().getTime());
		project.setEndDate(new Date(2022, 01, 01));
		project.setPjtName("업뎃텟");
		project.setTargetAmount(400000);
		map.clear();
		map.put("type", type);
		map.put("project", project);
	//	projectService.updatePjt(map);
		
		type="fund";
		project.setTotalFundCount(3000);
		project.setCollectedAmount(560000);
		map.clear();
		map.put("type", type);
		map.put("project", project);
	//	projectService.updatePjt(map);	
		
		LOGGER.info("updatePjt : "+projectService.getPjt(10000));
	}
	
	
	//@Test
	public void getProject() {

		project = sqlSession.selectOne("ProjectMapper.getPjt", 10000);
		
		LOGGER.info("getPjt : " +project);

	}

	//@Test
	public void getTotalFundCount() {
		
		LOGGER.info("totalFundCount : "+sqlSession.selectOne("ProjectMapper.getTotalFundCount", 10018));		
	}
	
	//@Test
	public void getCollectedAmount() {
		
		LOGGER.info("collectedAmount : "+sqlSession.selectOne("ProjectMapper.getCollectedAmount", 10018));	
		
	}
	
	//@Test
	public void getPjtListBanner() {
		
		

		String type = "banner";
		search.setCurrentPage(1);
		search.setPageSize(20);
		map.clear();
		map.put("search", search);
		map.put("type", type);
	//	List<Project> list = projectService.getPjtList(map);
		
		

	/*
	 * for(Project project : list) { LOGGER.info("getPjtList : " + project); }
	 */

	}
	
	//@Test
	public void getPjtListThemeConcern() {
		String type="";
		
		type= "themeConcern";
		List<String> concernList = new ArrayList<String>();
		concernList.add("0");
		concernList.add("1");
		concernList.add("2");
		concernList.add("3");
		concernList.add("4");
		
		search.setCurrentPage(1);
		search.setPageSize(20);
		map.clear();
		map.put("search", search);
		map.put("concernList", concernList);
		map.put("type",  type);
		
	//	List<Project> list = projectService.getPjtList(map);
		
	/*
	 * for(Project project : list) { LOGGER.info("getPjtList : " + project); }
	 */
	}
	
	//@Test
	public void getPjtListThemeSuccessIMI() {
		String type="";
		
		type = "themeSuccessIMI";
		
		search.setCurrentPage(1);
		search.setPageSize(20);
		map.clear();
		map.put("search", search);
		map.put("type",  type);
		
	//	List<Project> list = projectService.getPjtList(map);
		
	/*
	 * for(Project project : list) { LOGGER.info("getPjtList : " + project); }
	 */
	}
	
	//@Test
	public void getPjtListThemeEndIMI() {
		String type="";
		
		type = "themeEndIMI";
		
		search.setCurrentPage(1);
		search.setPageSize(20);
		map.clear();
		map.put("search", search);
		map.put("type",  type);
		
	//	List<Project> list = projectService.getPjtList(map);
		
	/*
	 * for(Project project : list) { LOGGER.info("getPjtList : " + project); }
	 */	
	}
	
	//@Test
	public void getPjtList() {
		String type="";
		
		type = "list";
		search.setSearchKeyword("test");
		search.setCurrentPage(1);
		search.setPageSize(20);
		List<String> categoryList = new ArrayList<String>();
		List<String> statusList = new ArrayList<String>();
		categoryList.add("0");
		categoryList.add("1");
		categoryList.add("2");
		categoryList.add("3");
		categoryList.add("4");
		statusList.add("00");
		statusList.add("01");
		statusList.add("02");
		statusList.add("03");
		map.clear();
		map.put("statusList", statusList);
		map.put("categoryList", categoryList);
		map.put("search", search);
		map.put("type",  type);
		map.put("arrange",  "arrangePopular");
		
	//	List<Project> list = projectService.getPjtList(map);
		
//		for(Project project : list) {
//			LOGGER.info("getPjtList : " + project);
//			}
		
	}
	
	//@Transactional
	//@Test
	public void deletePjt() {
		
		projectService.deletePjt(10025);
		
		LOGGER.info("deletePjt : " + projectService.getPjt(10025));
		
		
	}
	
	//@Transactional
	//@Test
	public void addFavorite() {
		
		Favorite favorite = new Favorite();
		favorite.setPjtNo(10025);
		favorite.setUserNo(10009);
		
		
		LOGGER.info("addFavorite : "+ projectService.addFavorite(favorite) );
	}
	
	//@Transactional
	//@Test
	public void deleteFavorite() {
		
		Favorite favorite = new Favorite();
		favorite.setPjtNo(10025);
		favorite.setUserNo(10009);
		
	//	LOGGER.info("deleteFavorite : "+ projectService.deleteFavorite(favorite) );
	}
	
	//@Test
	public void getFavoriteList() {
		
		List<Project> list = new ArrayList<Project>();
		
		list = projectService.getFavoriteList(10000);
		
		for(Project project : list) {
			LOGGER.info("getFavoriteList : " + project);
			}
	}
	
	//@Transactional
	//@Test
	public void addReview() {
		Review review = new Review();
		
		review.setPjtNo(10000);
		review.setUserNo(10000);
		review.setReviewContents("생각보다괜춘해요");
		review.setReviewScore(4.5);
		
		LOGGER.info(projectService.addReview(review));
		
	}


	
	//@Transactional
	//@Test
	public void updateReview() {
		String type = "";
		Review review = new Review();
		
		
		type = "addReply";
		review.setReviewReplyContents("업뎃리뷰댓글단위테스트");
		review.setReviewNo(10000);
		map.clear();
		map.put("type",  type);
		map.put("review", review);
//		LOGGER.info("addReply of updateReview : " + projectService.updateReview(map));
		
		type="editReview";
		review = new Review();
		review.setReviewNo(10000);
		review.setReviewContents("업뎃리뷰단위테스트");
		review.setReviewScore(1.5);
		map.clear();
		map.put("type",  type);
		map.put("review", review);
//		LOGGER.info("editReview of updateReview : " + projectService.updateReview(map));
		
		type="editReply";
		review = new Review();
		review.setReviewNo(10000);
		review.setReviewReplyContents("업뎃리뷰댓글수정단위테스트");
		map.clear();
		map.put("type",  type);
		map.put("review", review);
//		LOGGER.info("editReply of updateReview : " + projectService.updateReview(map));
		
		type="deleteReply";
		review = new Review();
		review.setReviewNo(10000);
		map.clear();
		map.put("type",  type);
		map.put("review", review);
//		LOGGER.info("deleteReply of updateReview : " + projectService.updateReview(map));
		
	}
	
	//@Transactional
	//@Test
	public void deleteReview() {

		LOGGER.info(projectService.deleteReview(10000));
		
	}
	
	//@Test
	public void getReviewList() {
		List<Review> list = projectService.getReviewList(10000);
		
		for(Review review : list) {
			LOGGER.info("getReviewList : "+ review);
		}
	}
	
	//@Transactional
	//@Test
	public void addPjtReport() {
		
		PjtReport pjtReport = new PjtReport();
		
		pjtReport.setPjtReportUserNo(10000);
		pjtReport.setPjtReportPjtNo(10000);
		pjtReport.setPjtReportType("0");
		pjtReport.setPjtReportContents("지적재산권 침해함");
		
		LOGGER.info("addPjtReport : " + projectService.addPjtReport(pjtReport));
		
	}
	
	//@Transactional
	//@Test
	public void getChat() {
		Chat chat = new Chat();
		chat = sqlSession.selectOne("ProjectMapper.getChat", "10001-10001");
		
		
		if( chat != null) {
			LOGGER.info("getChat :" + chat);
		}else {
			Chat addchat = new Chat();
			addchat.setChatNo(10008+"-"+10008);
			addchat.setChatTranTime(Calendar.getInstance().getTime());
			
			LOGGER.info("addChat :" + sqlSession.insert("ProjectMapper.addChat", addchat));
		}
	}
	
	//@Test
	public void getChatList() {
		
		List<Chat> list = projectService.getChatList(10001);
		
		for(Chat chat : list) {
			
			LOGGER.info("getChatList : " + chat);
			
		}
	}
	
	//@Transactional
	//@Test
	public void updateChatTranTime() {
		Chat chat = new Chat();
		chat.setChatNo(10001+"-"+10001);
		chat.setChatTranTime(Calendar.getInstance().getTime());
		LOGGER.info(" updateChatTranTime : " +projectService.updateChatTranTime(chat));
	}
	
	//@Transactional
	//@Test
	public void addPjtImg() {
		PjtImg pjtImg = new PjtImg();
		
		pjtImg.setType("0");
		pjtImg.setPjtReportNo(10000);
		pjtImg.setImg("REPORTREPORTREPORTREPORTREPORTREPORTfjeawlj329fj8oidh2387odho23");
		LOGGER.info("addPjtImg(Report) : "+ projectService.addPjtImg(pjtImg));

		pjtImg.setType("1");
		pjtImg.setPjtNoticeNo(10000);
		pjtImg.setImg("NOTICENOTICENOTICENOTICENOTICENOTICENOTICEfo234uqyf23o8f7");
		LOGGER.info("addPjtImg(Notice) : "+ projectService.addPjtImg(pjtImg));
		
		pjtImg.setType("2");
		pjtImg.setPjtReviewNo(10000);
		pjtImg.setImg("REVIEWREVIEWREVIEWREVIEWREVIEWREVIEWREVIEWREVIEWREVIEWREVIEWfo234uqyf23o8f7");
		LOGGER.info("addPjtImg(Review) : "+ projectService.addPjtImg(pjtImg));
	}
	
	
	//@Transactional
	//@Test
	public void deletePjtImgAll() {
		PjtImg pjtImg = new PjtImg();
		pjtImg.setType("0");
		pjtImg.setPjtReportNo(10000);
		LOGGER.info("deletePjtImgAll(REPORT) : " + projectService.deletePjtImgAll(pjtImg) );
		
		pjtImg.setType("1");
		pjtImg.setPjtNoticeNo(10000);
		LOGGER.info("deletePjtImgAll(NOTICE) : " + projectService.deletePjtImgAll(pjtImg) );
		
		pjtImg.setType("2");
		pjtImg.setPjtReviewNo(10000);
		LOGGER.info("deletePjtImgAll(REVIEW) : " + projectService.deletePjtImgAll(pjtImg) );
	}
	
	//@Transactional
	//@Test
	public void deletePjtImgOne() {
		LOGGER.info("deletePjtImgOne : " + projectService.deletePjtImgOne(10015) );
	}
	
	//@Test
	public void getPjtImgList() {
		PjtImg pjtImg = new PjtImg();
		pjtImg.setType("0");
		pjtImg.setPjtReportNo(10000);
		List<PjtImg> list = projectService.getPjtImgList(pjtImg);
		for(PjtImg temp : list) {
			LOGGER.info("getPjtImgList(REPORT) : " + temp);
		}
		pjtImg.setType("1");
		pjtImg.setPjtNoticeNo(10000);
		list.clear();
		list = projectService.getPjtImgList(pjtImg);
		for(PjtImg temp : list) {
			LOGGER.info("getPjtImgList(NOTICE) : " + temp);
		}
		pjtImg.setType("2");
		pjtImg.setPjtReviewNo(10000);
		list.clear();
		list = projectService.getPjtImgList(pjtImg);
		for(PjtImg temp : list) {
			LOGGER.info("getPjtImgList(REVIEW) : " + temp);
		}
	}
	
	
}

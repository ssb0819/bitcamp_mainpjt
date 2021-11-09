package com.fundingo.service.project.impl;

import java.beans.beancontext.BeanContextSupport;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fundingo.Application;
import com.fundingo.common.PjtCategory;
import com.fundingo.common.Search;
import com.fundingo.service.domain.Chat;
import com.fundingo.service.domain.Favorite;
import com.fundingo.service.domain.PjtImg;
import com.fundingo.service.domain.PjtReport;
import com.fundingo.service.domain.Product;
import com.fundingo.service.domain.Project;
import com.fundingo.service.domain.Review;
import com.fundingo.service.domain.User;
import com.fundingo.service.project.ProjectDao;
import com.fundingo.service.project.ProjectService;
import com.fundingo.service.user.UserDao;
import com.fundingo.service.user.UserService;

@Service
public class ProjectServiceImpl implements ProjectService {
	private static final Logger LOGGER = LogManager.getLogger(Application.class);
	@Autowired
	private ProjectDao projectDao;
	
	@Autowired
	private UserDao userDao;

	@Autowired
	private UserService userService;

	public ProjectServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	public Project getPjt(int pjtNo) {

		return projectDao.getPjt(pjtNo);
	};

	public List<Project> getPjtList(int userNo, String type, Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		User user = userDao.getUser(userNo);
		
		if(user == null) {
			user = new User();
		}
		
		
		if(search.getCurrentPage() == 0 && search.getPageSize()==0) {
		search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(20);
		}
		
		if (type.equals("themeConcern")) {
			List<String> concernList = new ArrayList<String>();

			if (user.getConcern1() != null) {
				concernList.add("0");
			}

			if (user.getConcern2() != null) {
				concernList.add("1");
			}

			if (user.getConcern3() != null) {
				concernList.add("2");
			}

			if (user.getConcern4() != null) {
				concernList.add("3");
			}

			if (user.getConcern5() != null) {
				concernList.add("4");
			}
			
			if(concernList.size()!=0) {
			map.put("concernList", concernList);
			
			}
			
			LOGGER.info("concernList @@@@@@@@@@@@@@ : " + concernList);
			
		}

		map.put("type", type);
		map.put("search", search);
		List<Project> temp = projectDao.getPjtList(map);
		
		if(type.equals("themeConcern")) {
			LOGGER.info("themeConcern size :@@@@@@@@@@" + temp.size());
		}
		
		
		if (temp != null) {
			for (int i = 0; i < temp.size(); i++) {
				Project project = temp.get(i);
				if (project.getCategory() != null) {
					if (project.getCategory().equals("0")) {
						project.setCategory(PjtCategory.category0);
					} else if (project.getCategory().equals("1")) {
						project.setCategory(PjtCategory.category1);
					} else if (project.getCategory().equals("2")) {
						project.setCategory(PjtCategory.category2);
					} else if (project.getCategory().equals("3")) {
						project.setCategory(PjtCategory.category3);
					} else if (project.getCategory().equals("4")) {
						project.setCategory(PjtCategory.category4);
					}
				}
				}
		}
		return temp;
	}

	public List<Project> getPjtList(String arrange, List<String> statusList, List<String> categoryList, Search search) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(search.getCurrentPage() == 0 && search.getPageSize()==0) {
			search = new Search();
			search.setCurrentPage(1);
			search.setPageSize(20);
		}

		String type = "list";
		map.put("arrange", arrange);
		map.put("type", type);
		map.put("search", search);
		map.put("statusList", statusList);
		map.put("categoryList", categoryList);
		List<Project> temp = projectDao.getPjtList(map);

		if (temp != null) {
			for (int i = 0; i < temp.size(); i++) {
				Project project = temp.get(i);
				if (project.getCategory() != null) {
					if (project.getCategory().equals("0")) {
						project.setCategory(PjtCategory.category0);
					} else if (project.getCategory().equals("1")) {
						project.setCategory(PjtCategory.category1);
					} else if (project.getCategory().equals("2")) {
						project.setCategory(PjtCategory.category2);
					} else if (project.getCategory().equals("3")) {
						project.setCategory(PjtCategory.category3);
					} else if (project.getCategory().equals("4")) {
						project.setCategory(PjtCategory.category4);
					}
				}
			}
		}

		return temp;
	}

	public List<Project> getPjtListByUserNo(int userNo) {
		List<Project> temp = projectDao.getPjtListByUserNo(userNo);
		
		if (temp != null) {
			for (int i = 0; i < temp.size(); i++) {
				Project project = temp.get(i);
				if (project.getCategory() != null) {
					if (project.getCategory().equals("0")) {
						project.setCategory(PjtCategory.category0);
					} else if (project.getCategory().equals("1")) {
						project.setCategory(PjtCategory.category1);
					} else if (project.getCategory().equals("2")) {
						project.setCategory(PjtCategory.category2);
					} else if (project.getCategory().equals("3")) {
						project.setCategory(PjtCategory.category3);
					} else if (project.getCategory().equals("4")) {
						project.setCategory(PjtCategory.category4);
					}
				}
			}
		}
		
		
		return temp;
	}

	public int updatePjt(Project project, String type) {

		return projectDao.updatePjt(project, type);
	}

	public int updatePjtStatus(Project project) {
		return projectDao.updatePjtStatus(project);
	}

	public int addPjt(Project project) {


		
		Project temp = projectDao.checkApply((project.getUser()).getUserNo());

		if (temp == null) {

			int pjtNo = projectDao.addPjt(project);
			Product product = new Product();
			product.setPjtNo(pjtNo);
			projectDao.addProduct(product);
			return pjtNo;

		} else {

			return temp.getPjtNo();
		}

	}

	public int deletePjt(int PjtNo) {

		return projectDao.deletePjt(PjtNo);
	}

	public int addProduct(Product product) {

		return projectDao.addProduct(product);
	}
	
	public int updateProduct(Product product) {
		return projectDao.updateProduct(product);
	}
	
	public int deleteProduct(int prodNo) {
		return projectDao.deleteProduct(prodNo);
	}

	public List<Product> getProdList(int pjtNo) {
		return projectDao.getProdList(pjtNo);
	}

	public int addFavorite(Favorite favorite) {
		return projectDao.addFavorite(favorite);
	}

	public Favorite getFavorite(int pjtNo, int userNo) {
		return projectDao.getFavorite(pjtNo, userNo);
	}

	public int deleteFavorite(int pjtNo, int userNo) {
		return projectDao.deleteFavorite(pjtNo, userNo);
	}

	public List<Project> getFavoriteList(int userNo) {
		return projectDao.getFavoriteList(userNo);
	}

	public int addReview(Review review) {
		return projectDao.addReview(review);
	}

	public int deleteReview(int reviewNo) {
		return projectDao.deleteReview(reviewNo);
	}

	public int updateReview(Review review, String type) {
		return projectDao.updateReview(review, type);
	}

	public List<Review> getReviewList(int pjtNo, int currentPage) {
		return projectDao.getReviewList(pjtNo, currentPage);
	}

	public int addPjtReport(PjtReport pjtReport) {
		return projectDao.addPjtReport(pjtReport);
	}

	public int addChat(int pjtNo, int userNo) {
		return projectDao.addChat(pjtNo, userNo);
	}

	public Chat getChat(int pjtNo, int userNo) {
		return projectDao.getChat(pjtNo, userNo);
	}

	public int updateChatTranTime(Chat chat) {
		return projectDao.updateChatTranTime(chat);
	}

	public List<Chat> getChatList(int userNo) {
		return projectDao.getChatList(userNo);
	}

	public int addPjtImg(PjtImg pjtImg) {
		return projectDao.addPjtImg(pjtImg);
	}

	public int deletePjtImgOne(int imgNo) {
		return projectDao.deletePjtImgOne(imgNo);
	}

	public int deletePjtImgAll(PjtImg pjtImg) {
		return projectDao.deletePjtImgAll(pjtImg);
	}

	public List<PjtImg> getPjtImgList(PjtImg pjtImg) {
		return projectDao.getPjtImgList(pjtImg);
	}
	
	public int getReviewTotalCount(int pjtNo) {
		return projectDao.getReviewTotalCount(pjtNo);
	}

}

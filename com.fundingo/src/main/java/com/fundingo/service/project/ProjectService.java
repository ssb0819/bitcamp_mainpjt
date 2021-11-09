package com.fundingo.service.project;

import java.util.List;
import java.util.Map;

import com.fundingo.common.Search;
import com.fundingo.service.domain.Chat;
import com.fundingo.service.domain.Favorite;
import com.fundingo.service.domain.PjtImg;
import com.fundingo.service.domain.PjtReport;
import com.fundingo.service.domain.Product;
import com.fundingo.service.domain.Project;
import com.fundingo.service.domain.Review;

public interface ProjectService {

	
	public Project getPjt(int pjtNo);
	
	public List<Project> getPjtList(int userNo, String type, Search search) throws Exception;
	
	public List<Project> getPjtList(String arrange, List<String> statusList, List<String> categoryList, Search search);
	
	public List<Project> getPjtListByUserNo(int userNo);
	
	public int addPjt(Project project);
	
	public int updatePjt(Project project, String type);
	
	public int updatePjtStatus(Project project);
	
	public int deletePjt(int PjtNo);
	
	public int addProduct(Product product);
	
	public int updateProduct(Product product);
	
	public int deleteProduct(int prodNo);
	
	public List<Product> getProdList(int pjtNo);
	
	public int addFavorite(Favorite favorite);
	
	public Favorite getFavorite(int pjtNo, int userNo);
	
	public int deleteFavorite(int pjtNo, int userNo);
	
	public List<Project> getFavoriteList(int userNo);
	
	public int addReview(Review review);
	
	public int deleteReview(int reviewNo);
	
	public int updateReview(Review review, String type);
	
	public List<Review> getReviewList(int pjtNo, int currentPage);
	
	public int addPjtReport(PjtReport pjtReport);
	
	public int addChat(int pjtNo, int userNo);
	
	public Chat getChat(int pjtNo, int userNo);
	
	public int updateChatTranTime(Chat chat);
	
	public List<Chat> getChatList(int userNo);
	
	public int addPjtImg(PjtImg pjtImg);
	
	public int deletePjtImgOne(int imgNo);
	
	public int deletePjtImgAll(PjtImg pjtImg);
	
	public List<PjtImg> getPjtImgList(PjtImg pjtImg);
	
	public int getReviewTotalCount(int pjtNo);
}

package com.fundingo.service.project.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.fundingo.Application;
import com.fundingo.common.Search;
import com.fundingo.service.domain.Chat;
import com.fundingo.service.domain.Favorite;
import com.fundingo.service.domain.PjtImg;
import com.fundingo.service.domain.PjtReport;
import com.fundingo.service.domain.Product;
import com.fundingo.service.domain.Project;
import com.fundingo.service.domain.Review;
import com.fundingo.service.project.ProjectDao;

@Repository
public class ProjectDaoImpl implements ProjectDao {

	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Project getPjt(int pjtNo) {
		return sqlSession.selectOne("ProjectMapper.getPjt", pjtNo);
	}
	
	public List<Project> getPjtList(Map<String, Object> map){
		return sqlSession.selectList("ProjectMapper.getPjtList", map);
	}
	
	public List<Project> getPjtListByUserNo(int userNo){
		return sqlSession.selectList("ProjectMapper.getPjtListByUserNo", userNo);
	}
	
	public int updatePjt(Project project, String type) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("type", type);
		map.put("project", project);
		return sqlSession.update("ProjectMapper.updatePjt", map);
	}
	
	public int updatePjtStatus(Project project) {
		return sqlSession.update("ProjectMapper.updatePjtStatus", project);
	}

	public int addPjt(Project project) {
		
		sqlSession.insert("ProjectMapper.addPjt", project);
		
		return project.getPjtNo();
	}
	
	public Project checkApply(int userNo) {
		return sqlSession.selectOne("ProjectMapper.checkApply", userNo);
	}
	
	public int deletePjt(int pjtNo) {
		return sqlSession.delete("ProjectMapper.deletePjt", pjtNo);
	}
	
	public int addProduct(Product product) {
		sqlSession.insert("ProjectMapper.addProduct", product);
		return product.getProdNo();
	}
	
	public int updateProduct(Product product) {
		return sqlSession.update("ProjectMapper.updateProduct", product);
	}
	
	public int deleteProduct(int prodNo) {
		return sqlSession.delete("ProjectMapper.deleteProduct", prodNo);
	}
	
	public List<Product> getProdList(int pjtNo){
		return sqlSession.selectList("ProjectMapper.getProdList", pjtNo);
	}
	
	public int addFavorite(Favorite favorite) {
		return sqlSession.insert("ProjectMapper.addFavorite", favorite);
	}
	
	public Favorite getFavorite(int pjtNo, int userNo) {
		Favorite favorite = new Favorite();
				
		favorite.setPjtNo(pjtNo);
		favorite.setUserNo(userNo);
		
		return sqlSession.selectOne("ProjectMapper.getFavorite", favorite); 
	}
	
	public int deleteFavorite(int pjtNo, int userNo) {
		Favorite favorite = new Favorite();
		
		favorite.setPjtNo(pjtNo);
		favorite.setUserNo(userNo);
		
		return sqlSession.delete("ProjectMapper.deleteFavorite", favorite);
	}
	public List<Project> getFavoriteList(int userNo){
		return sqlSession.selectList("ProjectMapper.getFavoriteList", userNo);
	}
	
	public int addReview(Review review) {
		return sqlSession.insert("ProjectMapper.addReview", review);
	}
	
	public int deleteReview(int reviewNo) {
		return sqlSession.delete("ProjectMapper.deleteReview", reviewNo);
	}
	
	public int updateReview(Review review, String type) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("review", review);
		map.put("type", type);
		return sqlSession.update("ProjectMapper.updateReview", map);
	}
	
	public List<Review> getReviewList(int pjtNo, int currentPage){
		
		Map<String, Object> map = new HashMap<String, Object>();
		if(currentPage == 0) {
			currentPage = 1;
		}
		
		Search search = new Search();
		
		search.setCurrentPage(currentPage);
		search.setPageSize(5);
		
		map.put("pjtNo", pjtNo);
		map.put("search", search);
		
		return sqlSession.selectList("ProjectMapper.getReviewList", map);
	}
	
	public int addPjtReport(PjtReport pjtReport) {
		return sqlSession.insert("ProjectMapper.addPjtReport", pjtReport);
	}
	
	public int addChat(int pjtNo, int userNo) {
		String chatNo = pjtNo + "-" + userNo;
		return sqlSession.insert("ProjectMapper.addChat", chatNo);
		
	}
	
	public Chat getChat(int pjtNo, int userNo) {
		String chatNo = pjtNo + "-" + userNo;
		return sqlSession.selectOne("ProjectMapper.getChat", chatNo);
	}
	
	public int updateChatTranTime(Chat chat) {
		return sqlSession.update("ProjectMapper.updateChatTranTime", chat);
	}
	
	public List<Chat> getChatList(int userNo){
		return sqlSession.selectList("ProjectMapper.getChatList", userNo);
	}
	
	public int addPjtImg(PjtImg pjtImg) {
		return sqlSession.insert("ProjectMapper.addPjtImg", pjtImg);
	}
	
	public int deletePjtImgOne(int imgNo) {
		return sqlSession.delete("ProjectMapper.deletePjtImgOne", imgNo);
	}
	
	public int deletePjtImgAll(PjtImg pjtImg) {
		return sqlSession.delete("ProjectMapper.deletePjtImgAll", pjtImg);
	}
	
	public List<PjtImg> getPjtImgList(PjtImg pjtImg){
		return sqlSession.selectList("ProjectMapper.getPjtImgList", pjtImg);
	}
	
	public int getReviewTotalCount(int pjtNo) {
		return sqlSession.selectOne("ProjectMapper.getReviewTotalCount", pjtNo);
	}
	
}

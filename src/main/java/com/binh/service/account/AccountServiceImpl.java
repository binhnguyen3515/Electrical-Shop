package com.binh.service.account;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.context.annotation.SessionScope;

import com.binh.model.User;
import com.binh.repository.Repository_User;

@SessionScope
@Service("account")
public class AccountServiceImpl implements AccountService{
	@Autowired private Repository_User repoUser;

	@Override
	public User login(String userID,String password) {
		Optional<User> optExist = repoUser.findById(userID);
		if(optExist.isPresent() && password.equals(optExist.get().getPassword())) {
//			optExist.get().setPassword("");
			return optExist.get();
		}
		if(optExist.isPresent() && !password.equals(optExist.get().getPassword())) {
			optExist.get().setUserID("wrongpass");
			return optExist.get();
		}
		return null;
	}
	
	@Override
	public List<User> findByIsdeletedFalse() {
		return repoUser.findByIsdeletedFalse();
	}

	@Override
	public List<User> findByIsdeletedTrue() {
		return repoUser.findByIsdeletedTrue();
	}

	@Override
	public <S extends User> S save(S entity) {
		return repoUser.save(entity);
	}

	@Override
	public <S extends User> Optional<S> findOne(Example<S> example) {
		return repoUser.findOne(example);
	}

	@Override
	public Page<User> findAll(Pageable pageable) {
		return repoUser.findAll(pageable);
	}

	@Override
	public List<User> findAll() {
		return repoUser.findAll();
	}

	@Override
	public List<User> findAll(Sort sort) {
		return repoUser.findAll(sort);
	}

	@Override
	public List<User> findAllById(Iterable<String> ids) {
		return repoUser.findAllById(ids);
	}

	@Override
	public Optional<User> findById(String id) {
		return repoUser.findById(id);
	}

	@Override
	public <S extends User> List<S> saveAll(Iterable<S> entities) {
		return repoUser.saveAll(entities);
	}

	@Override
	public void flush() {
		repoUser.flush();
	}

	@Override
	public <S extends User> S saveAndFlush(S entity) {
		return repoUser.saveAndFlush(entity);
	}

	@Override
	public boolean existsById(String id) {
		return repoUser.existsById(id);
	}

	@Override
	public <S extends User> List<S> saveAllAndFlush(Iterable<S> entities) {
		return repoUser.saveAllAndFlush(entities);
	}

	@Override
	public <S extends User> Page<S> findAll(Example<S> example, Pageable pageable) {
		return repoUser.findAll(example, pageable);
	}

	@Override
	public void deleteInBatch(Iterable<User> entities) {
		repoUser.deleteInBatch(entities);
	}

	@Override
	public <S extends User> long count(Example<S> example) {
		return repoUser.count(example);
	}

	@Override
	public <S extends User> boolean exists(Example<S> example) {
		return repoUser.exists(example);
	}

	@Override
	public void deleteAllInBatch(Iterable<User> entities) {
		repoUser.deleteAllInBatch(entities);
	}

	@Override
	public long count() {
		return repoUser.count();
	}

	@Override
	public void deleteById(String id) {
		repoUser.deleteById(id);
	}

	@Override
	public void deleteAllByIdInBatch(Iterable<String> ids) {
		repoUser.deleteAllByIdInBatch(ids);
	}

	@Override
	public void delete(User entity) {
		repoUser.delete(entity);
	}

	@Override
	public void deleteAllById(Iterable<? extends String> ids) {
		repoUser.deleteAllById(ids);
	}

	@Override
	public void deleteAllInBatch() {
		repoUser.deleteAllInBatch();
	}

	@Override
	public User getOne(String id) {
		return repoUser.getOne(id);
	}

	@Override
	public void deleteAll(Iterable<? extends User> entities) {
		repoUser.deleteAll(entities);
	}

	@Override
	public void deleteAll() {
		repoUser.deleteAll();
	}

	@Override
	public User getById(String id) {
		return repoUser.getById(id);
	}

	@Override
	public <S extends User> List<S> findAll(Example<S> example) {
		return repoUser.findAll(example);
	}

	@Override
	public <S extends User> List<S> findAll(Example<S> example, Sort sort) {
		return repoUser.findAll(example, sort);
	}
	
	
}

package com.binh.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.binh.model.DetailedInvoice;
@Repository
public interface Repository_DetailedInvoice extends JpaRepository<DetailedInvoice, String> {

}

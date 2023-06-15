package com.chtrembl.petstore.pet.repository;

import com.chtrembl.petstore.pet.model.Category;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PetCategoryRepository extends JpaRepository<Category, Long> {
}

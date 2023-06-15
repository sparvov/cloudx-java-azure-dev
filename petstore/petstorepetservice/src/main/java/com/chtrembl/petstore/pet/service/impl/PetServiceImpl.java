package com.chtrembl.petstore.pet.service.impl;

import java.util.stream.Collectors;

import javax.annotation.PostConstruct;

import com.chtrembl.petstore.pet.model.DataPreload;
import com.chtrembl.petstore.pet.repository.PetCategoryRepository;
import com.chtrembl.petstore.pet.repository.PetRepository;
import com.chtrembl.petstore.pet.repository.TagRepository;
import com.chtrembl.petstore.pet.service.PetService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PetServiceImpl implements PetService {

    @Autowired
    private DataPreload dataPreload;

    @Autowired
    private PetRepository petRepository;

    @Autowired
    private PetCategoryRepository petCategoryRepository;

    @Autowired
    private TagRepository tagRepository;

    @PostConstruct
    public void init() {
        var pets = dataPreload.getPets();

        var categories = pets.stream()
                .map(pet -> pet.getCategory())
                .distinct()
                .collect(Collectors.toList());
        petCategoryRepository.saveAllAndFlush(categories);

        petRepository.saveAllAndFlush(pets);
    }
}

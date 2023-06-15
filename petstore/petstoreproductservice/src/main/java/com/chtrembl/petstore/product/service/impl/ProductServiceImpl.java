package com.chtrembl.petstore.product.service.impl;

import java.util.stream.Collectors;

import javax.annotation.PostConstruct;

import com.chtrembl.petstore.product.model.DataPreload;
import com.chtrembl.petstore.product.repository.CategoryRepository;
import com.chtrembl.petstore.product.repository.ProductRepository;
import com.chtrembl.petstore.product.repository.TagRepository;
import com.chtrembl.petstore.product.service.ProductService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private DataPreload dataPreload;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private TagRepository tagRepository;

    @PostConstruct
    public void init() {
        var products = dataPreload.getProducts();

        var categories = products.stream()
                .map(product -> product.getCategory())
                .distinct()
                .collect(Collectors.toList());
        categoryRepository.saveAllAndFlush(categories);

        productRepository.saveAllAndFlush(products);
    }
}

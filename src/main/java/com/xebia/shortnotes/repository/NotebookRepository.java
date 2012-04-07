package com.xebia.shortnotes.repository;

import com.xebia.shortnotes.domain.Notebook;
import java.util.List;
import org.springframework.roo.addon.layers.repository.mongo.RooMongoRepository;

@RooMongoRepository(domainType = Notebook.class)
public interface NotebookRepository {

    List<com.xebia.shortnotes.domain.Notebook> findAll();
}

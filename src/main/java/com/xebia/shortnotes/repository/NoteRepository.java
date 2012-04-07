package com.xebia.shortnotes.repository;

import com.xebia.shortnotes.domain.Note;
import java.util.List;
import org.springframework.roo.addon.layers.repository.mongo.RooMongoRepository;

@RooMongoRepository(domainType = Note.class)
public interface NoteRepository {

    List<com.xebia.shortnotes.domain.Note> findAll();
}

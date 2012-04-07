package com.xebia.shortnotes.service;

import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;

import com.xebia.shortnotes.domain.Note;
import com.xebia.shortnotes.domain.Notebook;


public class NoteServiceImpl implements NoteService {
	
	@Autowired
	MongoTemplate mongoTemplate;
	
	public void updateNotesWithNoteBook(Notebook notebook){
		Update update = new Update().set("notebook.name", notebook.getName()).set("notebook.author", notebook.getAuthor());
		Query query = Query.query(Criteria.where("notebook._id").is(new ObjectId(notebook.getId().toString(16))));
		mongoTemplate.updateMulti(query, update, Note.class);
	}
	
	public void removeNotes(Notebook notebook){
		mongoTemplate.remove(Query.query(Criteria.where("notebook._id").is(new ObjectId(notebook.getId().toString(16)))), Note.class);
	}
}

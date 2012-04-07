package com.xebia.shortnotes.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.xebia.shortnotes.domain.Note;
import com.xebia.shortnotes.domain.Notebook;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:/META-INF/spring/applicationContext*.xml")
public class NoteServiceImplTest {

	@Autowired
	private MongoTemplate mongoTemplate;
	@Autowired
	private NoteService noteService;
	@Autowired
	private NotebookService notebookService;
	private Notebook notebook;
	private Note note;
	
	@Before
	public void init(){
		mongoTemplate.dropCollection(Notebook.class);
		mongoTemplate.dropCollection(Note.class);
		notebook = new Notebook();
		notebook.setAuthor("shekhar");
		notebook.setName("MongoDB Notes");
		mongoTemplate.insert(notebook);
		
		notebook = mongoTemplate.findOne(Query.query(Criteria.where("author").is("shekhar")), Notebook.class);
		
		note = new Note();
		note.setContent("Getting started with MongoDb");
		note.setTitle("Getting started with MongoDb");
		note.setNotebook(notebook);
		
		mongoTemplate.insert(note);
		
	}
	
	@After
	public void cleanup(){
		mongoTemplate.dropCollection(Notebook.class);
		mongoTemplate.dropCollection(Note.class);
	}
	@Test
	public void testUpdateNotesWithNoteBook() {
		notebook.setName("MongoDB handbook");
		notebook.setAuthor("tom");
		notebookService.updateNotebook(notebook);
		
		noteService.updateNotesWithNoteBook(notebook);
		
		Note updateNote = mongoTemplate.findOne(Query.query(Criteria.where("id").is(note.getId())), Note.class);
		
		assertEquals("tom",updateNote.getNotebook().getAuthor());
		assertEquals("MongoDB handbook", updateNote.getNotebook().getName());
	}
	
	@Test
	public void shouldDeleteAllNoteForNotebook(){
		notebookService.deleteNotebook(notebook);
		
		noteService.removeNotes(notebook);
		Note deletedNote = mongoTemplate.findOne(Query.query(Criteria.where("id").is(note.getId())), Note.class);
		
		assertNull(deletedNote);
	}

}
